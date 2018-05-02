binding strategy
queryDefaultHighlightingBindingStrategy
	<gtExample>
	<label: 'Query default highlighting binding strategy'>
	| strategy result |
	strategy := self defaultHighlightingBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy