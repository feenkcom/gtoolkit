binding
at: anInteger 
	^ (collection at: anInteger ifAbsent: [ nil ]) 
		ifNotNil: [ :aCodeSnippet | aCodeSnippet value ]