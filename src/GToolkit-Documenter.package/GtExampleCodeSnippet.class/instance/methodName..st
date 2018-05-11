accessing
methodName: aString
	| aCollection aMethodClassName aMethodName |
	self assert: [ aString isString ] description: [ 'Example method name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Example method name has to be a non-empty string' ].

	aCollection := '>>#' split: aString.
	aMethodClassName := aCollection first.
	aMethodName := aCollection second.

	methodDefinition := RGMethodDefinition 
		class: (RGBehaviorDefinition named: aMethodClassName) 
		selector: aMethodName.