accessing
edgeElementFor: anObject from: fromElement to: toElement
	| edgeElement |
	edgeElement := elementBlock
		ifNotNil: [ elementBlock value: anObject ]
		ifNil: [ self defaultEdgeElement ].
	edgeElement
		fromAnchor: (BlGeometryAttachPointAnchor attachPoint: fromElement);
		toAnchor: (BlGeometryAttachPointAnchor attachPoint: toElement).
	edgeElement mondrianModel: anObject.
	edgeElement beMondrianEdge.
	^ edgeElement