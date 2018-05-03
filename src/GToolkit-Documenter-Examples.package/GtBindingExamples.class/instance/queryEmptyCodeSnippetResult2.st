code snippet result
queryEmptyCodeSnippetResult2
	<gtExample>
	<label: 'Query result of empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self codeSnippetResult.
	result := emptyBindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ emptyBindings