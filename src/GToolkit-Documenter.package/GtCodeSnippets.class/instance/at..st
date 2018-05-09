binding
at: anInteger 
	^ (self scriptAt: anInteger) 
		ifNotNil: [ :aCodeSnippet | aCodeSnippet value ]