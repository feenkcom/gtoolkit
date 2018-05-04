adding
addCodeSnippet: aGtCodeSnippetResult 
	"outs add: aGtCodeSnippetResult"
	outs insertScript: aGtCodeSnippetResult at: aGtCodeSnippetResult index.
	aGtCodeSnippetResult index + 1 to: outs size do: [ :anIndex | 
		(self outs scriptAt: anIndex) index: anIndex ].