simple example definition
codeSnippetOfDocumentWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithOneExampleCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet