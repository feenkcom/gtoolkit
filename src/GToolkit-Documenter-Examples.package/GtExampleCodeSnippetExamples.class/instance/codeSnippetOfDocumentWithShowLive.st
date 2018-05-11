example with show live parameter
codeSnippetOfDocumentWithShowLive
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with showLive'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithShowLive.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarElementWithShowLive'.
	self assert: aCodeSnippet showMessageName equals: GtDocumenterConstants defaultShowLiveMethodName.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet