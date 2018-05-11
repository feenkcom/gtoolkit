partial example definition
codeSnippetOfDocumentWithPartialDefinition
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with partial definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithPartialDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#'''''.
	self assert: aCodeSnippet shouldDisplayResult not.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet