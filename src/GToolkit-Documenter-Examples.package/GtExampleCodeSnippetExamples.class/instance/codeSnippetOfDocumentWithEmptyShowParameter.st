example with empty show definition
codeSnippetOfDocumentWithEmptyShowParameter
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with an empty show parameter'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithEmptyShowParameter.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet