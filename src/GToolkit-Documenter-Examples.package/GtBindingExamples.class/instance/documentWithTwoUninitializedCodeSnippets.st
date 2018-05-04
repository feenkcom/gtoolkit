document
documentWithTwoUninitializedCodeSnippets
	<gtExample>
	| codeSnippetOne document codeSnippetTwo result |
	document := self emptyDocument.
	codeSnippetOne := self codeSnippetResult.
	codeSnippetOne document: document.
	codeSnippetTwo := self codeSnippetResult.
	codeSnippetTwo document: document.
	result := codeSnippetTwo bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ document