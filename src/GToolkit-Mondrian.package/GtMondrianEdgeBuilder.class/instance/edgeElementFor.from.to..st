private
edgeElementFor: anObject from: fromElement to: toElement
	| edgeElement |
	edgeElement := self edgeElementFor: anObject.
	edgeElement
		fromAnchor: (fromAnchorClass element: fromElement);
		toAnchor: (toAnchorClass element: toElement).
	edgeElement mondrianModel: anObject.
	edgeElement beMondrianEdge.
	^ edgeElement