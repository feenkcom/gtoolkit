actions
find
	"If there is less scripts, create new one."

	<return: #GtCodeSnippetResult>
	self scriptIndex > self numberOfCodeSnippets
		ifTrue: [ ^ self newOrExistingCodeSnippet ].
	self hasSimilarSourceCodeAtSameIndex
		ifTrue: [ ^ self scriptAtSameIndex ].
	self hasSimilarSourceCodeAtFollowingIndex
		ifTrue: [ 
			self removeScriptAtSameIndex. 
			^ self scriptAtSameIndex ]. 
	^ self newCodeSnippetAtSameIndex