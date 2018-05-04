adding
insertScript: aGtCodeSnippetResult at: anInteger 
	collection add: aGtCodeSnippetResult beforeIndex: anInteger.
	self assert: (collection at: anInteger) == aGtCodeSnippetResult.