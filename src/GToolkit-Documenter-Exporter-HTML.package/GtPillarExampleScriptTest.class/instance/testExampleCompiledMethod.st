tests
testExampleCompiledMethod
	instance := self classToTest new.
	instance parameters at: 'example' put: self class name , 'class>>#stringExample'.
	self assert: instance exampleCompiledMethod equals: self class class >> #stringExample.