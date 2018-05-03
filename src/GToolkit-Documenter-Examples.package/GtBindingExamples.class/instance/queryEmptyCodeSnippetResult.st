code snippet result
queryEmptyCodeSnippetResult
	<gtExample>
	<label: 'Query empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self codeSnippetResult.
	result := emptyBindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ emptyBindings