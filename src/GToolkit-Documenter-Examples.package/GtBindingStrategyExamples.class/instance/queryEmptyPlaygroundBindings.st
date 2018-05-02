bindings
queryEmptyPlaygroundBindings
	<gtExample>
	<label: 'Query empty bindings'>
	| emptyBindings result |
	emptyBindings := self playgroundBindings.
	result := emptyBindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ emptyBindings