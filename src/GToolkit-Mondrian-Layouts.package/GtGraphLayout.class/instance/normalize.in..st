layout
normalize: anElement in: aRectangle
	| boundingBox delta |
	
	self isStopped
		ifTrue: [ ^ false ].
	
	boundingBox := self boundingBox: anElement.
	delta := (aRectangle extent / 2.0) - boundingBox center.

	anElement childrenDo: [ :child | child position: child position + delta ]