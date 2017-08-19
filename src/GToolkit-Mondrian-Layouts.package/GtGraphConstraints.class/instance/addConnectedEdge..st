accessing
addConnectedEdge: anEdge

	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]