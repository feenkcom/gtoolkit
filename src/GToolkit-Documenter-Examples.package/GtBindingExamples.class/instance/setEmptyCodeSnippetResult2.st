code snippet result
setEmptyCodeSnippetResult2
	<gtExample>
	<label: 'Set result of empty code snippet bindings'>
	| bindings result |
	bindings := self codeSnippetResult.
	bindings addNamed: GtDocumenterConstants resultVariableName value: 42.
	result := bindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ bindings