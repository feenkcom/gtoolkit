example with expanded preview
codeSnippetOfDocumentWithExpandedPreview
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with expanded preview'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithExpandedPreview.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aCodeSnippet shouldExpandPreview.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet