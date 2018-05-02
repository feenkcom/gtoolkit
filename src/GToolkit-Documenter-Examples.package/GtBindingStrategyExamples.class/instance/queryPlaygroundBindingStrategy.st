binding strategy
queryPlaygroundBindingStrategy
	<gtExample>
	<label: 'Query playground binding strategy'>
	| strategy result |
	strategy := self playgroundBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result key equals: self variableOneName.
	self assert: result value equals: nil.
	^ result