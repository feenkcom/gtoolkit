binding
at: anInteger 
	^ (self codeSnippetAt: anInteger) 
		ifNotNil: [ :aCodeSnippet | aCodeSnippet value ]