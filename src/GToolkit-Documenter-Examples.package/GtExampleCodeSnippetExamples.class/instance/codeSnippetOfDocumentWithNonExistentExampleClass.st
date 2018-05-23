non-existent example class
codeSnippetOfDocumentWithNonExistentExampleClass
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with non-existent example class'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleClass.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtDocumenterNonExistentClass>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet