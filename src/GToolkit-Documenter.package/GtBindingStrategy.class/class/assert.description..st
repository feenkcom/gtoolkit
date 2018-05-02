asserting
assert: aBlock description: aStringOrBlock
	"Throw an assertion error if aBlock does not evaluates to true.
	We check for true explicitly to make the assertion fail for non booleans."
	
	self isAssertionEnabled
		ifTrue: [ (aBlock value == true) ifFalse: [ 
				AssertionFailure signal: aStringOrBlock value ] ]