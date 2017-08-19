building - edges
edgeFrom: fromElement to: toElement
	| edge |
	edge := GtGraphEdge new from: fromElement to: toElement.
	fromElement constraints graph addConnectedEdge: edge.
	toElement constraints graph addConnectedEdge: edge.
	^ edge