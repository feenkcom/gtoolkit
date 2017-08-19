hook-private
computeChildrenFor: aNode
	^ self childrenFor: aNode except: alreadyLayoutedNodes