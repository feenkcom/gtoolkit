adding
addCodeSnippet: aGtCodeSnippetResult 
	"outs add: aGtCodeSnippetResult"
	codeSnippets insertScript: aGtCodeSnippetResult at: aGtCodeSnippetResult index.
	aGtCodeSnippetResult index + 1 to: codeSnippets size do: [ :anIndex | 
		(self outs codeSnippetAt: anIndex) index: anIndex ].