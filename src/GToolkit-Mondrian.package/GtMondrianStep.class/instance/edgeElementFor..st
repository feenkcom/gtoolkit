accessing
edgeElementFor: anObject
	^ elementBlock
		ifNotNil: [ elementBlock value: anObject ]
		ifNil: [ self defaultEdgeElement ]