document
documentWithTwoUninitializedCodeSnippets
	<gtExample>
	| codeSnippetOne document codeSnippetTwo result |
	document := self emptyDocument.
	codeSnippetOne := self codeSnippetResult.
	codeSnippetOne index: 1.
	codeSnippetOne document: document.
	codeSnippetTwo := self codeSnippetResult.
	codeSnippetTwo index: 2.
	codeSnippetTwo document: document.
	result := codeSnippetTwo bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ document