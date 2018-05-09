removing
remove: aGtCodeSnippetResult 
	collection remove: aGtCodeSnippetResult.
	aGtCodeSnippetResult index to: collection size do: [ :index | 
		(collection at: index) index: index ]