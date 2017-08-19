utils
thetaOf: aNode
	^ aNode userData at: #theta ifAbsent: [ ^ 0 ]