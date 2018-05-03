document
documentWithOneCodeSnippet
	<gtExample>
	| codeSnippet document |
	document := self emptyDocument.
	codeSnippet := self codeSnippetResult.
	codeSnippet result value: 108.
	codeSnippet document: document.
	^ document