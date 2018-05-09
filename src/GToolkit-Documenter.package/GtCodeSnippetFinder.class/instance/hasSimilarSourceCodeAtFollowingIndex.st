testing
hasSimilarSourceCodeAtFollowingIndex
	^ self numberOfCodeSnippets > self scriptIndex and: [ 
		(self scriptAtFollowingIndex sourceCode = self sourceCode) or: [ 
			self sourceCode endsWith: self scriptAtFollowingIndex sourceCode ] ]