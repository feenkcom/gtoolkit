code snippet result
setCodeSnippetResult
	<gtExample>
	| bindings |
	bindings := self codeSnippetWithPlaygroundBindings.
	bindings addNamed: self variableOneName value: 42.
	self assert: bindings result value isNil.
	^ bindings