asserting
assert: aBlock
	self 
		assert: aBlock 
		description: [ AssertionFailure signal: 'Assertion failed' ]