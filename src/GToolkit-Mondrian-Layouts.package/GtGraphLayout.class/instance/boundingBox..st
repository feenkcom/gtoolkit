layout
boundingBox: anElement
	| aBoundingBox |
	
	anElement children isEmpty
		ifTrue: [ ^ BlBounds new asRectangle ].

	aBoundingBox := BlBounds fromRectangle: anElement children first measuredBounds bounds.
	self
		layeredChildren: anElement
		do: [ :aChild | aBoundingBox merge: aChild measuredBounds bounds ].
	^ aBoundingBox asRectangle