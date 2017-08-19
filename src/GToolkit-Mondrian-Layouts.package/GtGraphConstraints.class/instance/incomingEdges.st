accessing
incomingEdges
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e toElement constraints graph == self ]