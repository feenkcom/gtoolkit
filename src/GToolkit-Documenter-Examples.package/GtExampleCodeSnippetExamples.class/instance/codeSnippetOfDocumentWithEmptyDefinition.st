empty example definition
codeSnippetOfDocumentWithEmptyDefinition
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with empty definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet