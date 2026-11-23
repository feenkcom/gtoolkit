Extension { #name : #FFICallout }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> aliasForType: aTypeName [
	"TypeAliases has Symbol keys (built from a literal array); type names arrive as Strings (resolveType: trims them)"
	<gtPharoPatch: #StrictComparison>
	| alias |

	alias := aTypeName.
	(requestor isNotNil and: [ requestor respondsTo: #externalTypeAlias: ])
		ifTrue: [
			alias := requestor externalTypeAlias: aTypeName.
			alias ifNil: [ alias := aTypeName ] ].
	" internal aliases "
	^ TypeAliases at: alias asSymbol ifAbsent: [ alias ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> loaderForArgNamed: argName [
	"Argument names are Symbols in literal-array signatures and Strings in String signatures"
	<gtPharoPatch: #StrictComparison>
	| loader |
	"try getting the argument from the method arguments"
	loader := self loaderFromMethodArgsNamed: argName.
	loader ifNil: [
		"special case, receiver argument"
		argName asString = 'self' ifTrue: [ loader := self receiverArgumentLoader ].
		loader ifNil: [
			"Ask the requestor for the argument"
			loader := requestor ffiInstVarArgument: argName generator: self.
			loader ifNil: [ | binding |
				binding := requestor ffiBindingOf: argName.
				binding ifNil: [ FFIVariableNameNotFound signalFor: argName].
				loader := FFIClassVariableArgument new
					argName: argName;
					yourself ] ] ].
	^ loader
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> loaderFromMethodArgsNamed: argName [
	"methodArgs are the method's argumentNames (Symbols)"
	<gtPharoPatch: #StrictComparison>
	| index |
	methodArgs ifNil: [ ^ nil ].
	index := methodArgs indexOf: argName asSymbol ifAbsent: [ nil ].
	^ index ifNotNil: [
		"ok, this is a method argument"
		^ FFIMethodArgument new
			argName: argName;
			index: index;
			yourself ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> resolveType: aTypeName [
	" a type name could be
	 - a class variable name
	- a class name
	- a type name
	- a type name, followed by arbitrary number pointer chars - $*"
	"An alias can answer a Symbol: compare as Strings in the loop"
	<gtPharoPatch: #StrictComparison>
	| name newName resolver binding ptrArity |

	newName := aTypeName.
	ptrArity := 0.
	"resolve aliases and pointers"
	[
		name := newName asString trimRight.
		newName := self aliasForType: name.
		newName last = $* ifTrue: [
			ptrArity := ptrArity + 1.
			newName := newName allButLast ].
		name = newName asString
	] whileFalse.

	resolver := requestor
		ifNotNil: [
			requestor isClass
				ifTrue: [ requestor instanceSide ]
				ifFalse: [ requestor ] ]
		ifNil: [ self class ].

	binding := resolver ffiBindingOf: name asSymbol.
	binding ifNotNil: [
		^ (binding value asExternalTypeOn: self) pointerArity: ptrArity ].

	^ self error: 'Unable to resolve external type: ' , aTypeName asString
]
