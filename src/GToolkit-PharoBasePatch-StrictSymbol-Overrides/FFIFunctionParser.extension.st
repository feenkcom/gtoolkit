Extension { #name : #FFIFunctionParser }

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
