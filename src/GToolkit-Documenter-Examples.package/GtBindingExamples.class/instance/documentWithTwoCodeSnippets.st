document
documentWithTwoCodeSnippets
	<gtExample>
	| codeSnippet document out |
	document := self documentWithOneCodeSnippet.
	codeSnippet := self codeSnippetResult.
	codeSnippet value: 7.
	codeSnippet document: document.
	out := codeSnippet bindingOf: GtDocumenterConstants resultVariableName.
	self assert: out notNil.
	self assert: out value equals: 108.
	^ document