code snippet result
queryCodeSnippetResult2
	<gtExample>
	<label: 'Set code snippet result'>
	| bindings result |
	bindings := self setCodeSnippetResult2.
	result := bindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ bindings