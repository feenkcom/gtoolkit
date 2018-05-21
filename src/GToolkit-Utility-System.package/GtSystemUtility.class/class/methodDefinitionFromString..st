ring definition
methodDefinitionFromString: aString
	"Extract a method definition, e.g., MyClass>>#methodOne and return method definition"
	<return: #RGMethodDefinition>
	| aCollection aMethodClassName aMethodName |
	self 
		assert: [ aString isString ] 
		description: [ 'Method definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Method definition name has to be a non-empty string' ].

	aCollection := '>>#' split: aString.
	aMethodClassName := aCollection first trimBoth.
	aMethodName := aCollection size = 2 ifTrue: [ aCollection second trimBoth ] ifFalse: [ '' ].

	^ RGMethodDefinition 
		class: (RGBehaviorDefinition named: aMethodClassName) 
		selector: aMethodName.