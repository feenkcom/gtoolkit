accessing
codeSnippet: aGtDebuggableCodeSnippet
	self 
		assert: [ aGtDebuggableCodeSnippet isNotNil ] 
		description: [ 'Code snippet has to be initialized' ].
	codeSnippet := aGtDebuggableCodeSnippet