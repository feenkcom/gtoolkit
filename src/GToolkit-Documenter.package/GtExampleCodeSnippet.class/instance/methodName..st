accessing
methodName: aString
	| aCollection aMethodClassName aMethodName |
	self assert: [ aString isString ] description: [ 'Example method name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Example method name has to be a non-empty string' ].

	aCollection := '>>#' split: aString.
	aMethodClassName := aCollection first.
	aMethodName := aCollection size = 2 ifTrue: [ aCollection second ] ifFalse: [ '' ].

	methodDefinition := RGMethodDefinition 
		class: (RGBehaviorDefinition named: aMethodClassName) 
		selector: aMethodName.