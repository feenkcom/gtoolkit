accessing
removeConnectedEdge: anEdge

	self connectedEdges remove: anEdge ifAbsent: [ "Some tests failed." ]