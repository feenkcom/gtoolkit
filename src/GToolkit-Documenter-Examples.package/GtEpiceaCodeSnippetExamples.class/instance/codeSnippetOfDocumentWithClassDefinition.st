class definition
codeSnippetOfDocumentWithClassDefinition
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with class definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithClassDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet