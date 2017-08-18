accessing
edgeConstraintsFrom: fromElement to: toElement
	| edge |
	edge := BlGraphEdge new from: fromElement to: toElement.
	fromElement constraints graph addConnectedEdge: edge.
	toElement constraints graph addConnectedEdge: edge