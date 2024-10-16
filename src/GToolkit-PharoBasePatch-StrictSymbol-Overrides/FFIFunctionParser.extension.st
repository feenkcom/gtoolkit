Extension { #name : #FFIFunctionParser }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIFunctionParser >> parseArgument [
	| argument argName indirectIndex typeAndPtrArity next |
	" An argument can be:

 - nil , true , false
 - a class/pool variable name
 - integer literal

 - self , with optional **
 - type name *** arg name

"
	"constant conditions"
	(stream contents size = 1 and: [
		stream contents first ~= #void ]) ifTrue: [
		^ self integerConstantArgument: stream next ].
	stream peek isArray ifTrue: [
		^ self parseArgumentCastedType ].

	"none of them, parse type and name"
	typeAndPtrArity := self parseType.
	argName := stream next.
	next := stream peek.
	next = $@
		ifTrue: [
			stream next.
			argName := argName.
			indirectIndex := self parseInt ].
	"for sole 'void' fake argument "
	((typeAndPtrArity first sameContentAs: 'void') and: [ typeAndPtrArity second = 0 and: [ argName isNil ]])
		ifTrue: [ ^ nil ].
	argument := self
		argName: argName
		indirectIndex: indirectIndex
		type: typeAndPtrArity first
		ptrArity: typeAndPtrArity second.

	^ argument
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIFunctionParser >> parseType [
	" parse type name and optional number of asterisks, following it"
	| typeName ptrArity |

	typeName := stream next.
	typeName ifNil: [ ^ self error: 'type name expected' ].	"skip 'const' , which is often used but has no any use for us "
	typeName = #const
		ifTrue: [ typeName := stream next.
			typeName ifNil: [ ^ self error: 'type name expected' ] ].

	ptrArity := 0.
	[ stream atEnd not
		and: [ stream peek isString and: [ stream peek beginsWith: '*' ] ] ]
		whileTrue: [ | pointerMarker |
			pointerMarker := stream next.
			self assert: (pointerMarker allSatisfy: [ :e | e = $* ]).
			ptrArity := ptrArity + pointerMarker size ].	"Answer a tuple name, arity"
	^ {typeName.
		ptrArity}
]
