non-existent example method
codeSnippetOfDocumentWithNonExistentExampleMethod
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with non-existent example method'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleMethod.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult not.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet