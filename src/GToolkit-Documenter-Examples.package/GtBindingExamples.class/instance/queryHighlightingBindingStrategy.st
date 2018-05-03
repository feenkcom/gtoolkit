binding strategy
queryHighlightingBindingStrategy
	<gtExample>
	<label: 'Query highlighting binding strategy'>
	| strategy result |
	strategy := self highlightingBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy