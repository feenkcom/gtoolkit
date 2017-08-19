accessing
outgoingEdges
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e fromElement constraints == self ]