tests
testTextDefault
	instance := self classToTest new.
	self assert: instance text isNil.