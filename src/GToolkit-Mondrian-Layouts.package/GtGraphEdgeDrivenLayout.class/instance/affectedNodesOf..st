accessing
affectedNodesOf:  aNode 
	^ affectedNodes ifNil: [ aNode nodes ]