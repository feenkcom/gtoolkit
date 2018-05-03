binding strategy
queryDefaultPlaygroundBindingStrategy
	<gtExample>
	<label: 'Query default playground binding strategy'>
	| strategy result |
	strategy := self defaultPlaygroundBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy