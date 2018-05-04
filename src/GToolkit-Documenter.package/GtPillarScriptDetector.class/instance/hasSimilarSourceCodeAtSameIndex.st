testing
hasSimilarSourceCodeAtSameIndex
	^ (self scriptAtSameIndex sourceCode = self sourceCode) or: [ 
		self sourceCode endsWith: self scriptAtSameIndex sourceCode ]