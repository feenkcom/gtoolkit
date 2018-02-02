tests
testExampleSourceCode
	instance := self classToTest new.
	instance parameters at: 'example' put: self class name , ' class>>#stringExample'.
	self 
		assert: instance exampleSourceCode 
		equals: self class class name asString, ' >> ', (self class class >> #stringExample) sourceCode.