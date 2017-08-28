accessing
edgeElementFor: anObject from: fromElement to: toElement
	| edgeElement |
	edgeElement := elementBlock
		ifNotNil: [ elementBlock value: anObject ]
		ifNil: [ self defaultEdgeElement ].
	edgeElement
		fromAnchor: (BlElementBottomCenterAnchor element: fromElement);
		toAnchor: (BlElementTopCenterAnchor element: toElement).
	edgeElement mondrianModel: anObject.
	edgeElement beMondrianEdge.
	^ edgeElement