accessing
methodName: aString
	self assert: [ aString isString ] description: [ 'Example method name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Example method name has to be a non-empty string' ].
	
	methodName := aString