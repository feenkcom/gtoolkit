accessing
before: aGtCodeSnippetResult 
	<return: #LiteralVariable or: nil>
	| anIndex |
	anIndex := collection indexOf: aGtCodeSnippetResult.
	anIndex < 1 ifTrue: [ ^ nil ].
	^ (collection at: anIndex - 1) result