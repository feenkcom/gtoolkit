document
documentWithOneCodeSnippet
	<gtExample>
	| codeSnippet document |
	document := self emptyDocument.
	codeSnippet := self codeSnippetResult.
	codeSnippet value: 108.
	codeSnippet document: document.
	^ document