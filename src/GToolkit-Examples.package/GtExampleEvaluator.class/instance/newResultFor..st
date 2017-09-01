private
newResultFor: anExample
	self flag: 'No context for the result in this evaluator'.
	^ GTExampleResult new 
		example: anExample;
		"context: self context;"
		yourself.