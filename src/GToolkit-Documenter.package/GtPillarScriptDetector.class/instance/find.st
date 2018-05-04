actions
find
	"If there is less scripts, create new one."

	<return: #GtCodeSnippetResult>
	self scriptIndex > self numberOfCodeSnippets
		ifTrue: [ ^ self newCodeSnippet ].
	self hasSimilarSourceCodeAtSameIndex
		ifTrue: [ ^ self scriptAtSameIndex ].
	^ self newCodeSnippetAtSameIndex