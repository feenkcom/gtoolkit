Extension { #name : #FFICallout }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> loaderForArgNamed: argName [
	| loader |

	"try getting the argument from the method arguments"
	loader := self loaderFromMethodArgsNamed: argName.
	loader
		ifNil: [  "special case, receiver argument"argName = #self
				ifTrue: [ loader := self receiverArgumentLoader ].
			loader
				ifNil: [  "Ask the requestor for the argument"loader := requestor
							ffiInstVarArgument: argName
							generator: self.
					loader
						ifNil: [ | binding |
							binding := requestor ffiBindingOf: argName.
							binding ifNil: [ FFIVariableNameNotFound signalFor: argName ].
							loader := FFIClassVariableArgument new
									argName: argName;
									yourself ] ] ].
	^ loader
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> resolveType: aTypeName [
	" a type name could be
	 - a class variable name
	- a class name
	- a type name
	- a type name, followed by arbitrary number pointer chars - $*"

	| name newName resolver binding ptrArity |
	newName := aTypeName.
	ptrArity := 0.	"resolve aliases and pointers"
	[ name := newName asString trimRight.
	newName := self aliasForType: name.
	newName last = $*
		ifTrue: [ ptrArity := ptrArity + 1.
			newName := newName allButLast ].
	name sameContentAs: newName ] whileFalse.

	resolver := requestor
			ifNotNil: [ requestor isClass ifTrue: [ requestor instanceSide ] ifFalse: [ requestor ] ]
			ifNil: [ self class ].

	binding := resolver ffiBindingOf: name asSymbol.
	binding
		ifNotNil: [ ^ (binding value asExternalTypeOn: self) pointerArity: ptrArity ].

	^ self error: 'Unable to resolve external type: ' , aTypeName asString
]
