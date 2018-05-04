code snippet result
setEmptyCodeSnippetResult2
	<gtExample>
	<label: 'Set result of empty code snippet bindings'>
	| bindings result |
	bindings := self codeSnippetResult.
	bindings value: 42.
	result := bindings
		bindingOf: GtDocumenterConstants resultVariableName.
	"The result is nil, because out refers to a previous script."
	self assert: result isNil.
	^ bindings