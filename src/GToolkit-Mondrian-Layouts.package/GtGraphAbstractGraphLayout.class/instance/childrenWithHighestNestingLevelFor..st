private
childrenWithHighestNestingLevelFor: aNode
	
	^(self childrenFor: aNode)
		select: [:eachChild | (self highestNestingParentFor: eachChild) == aNode]