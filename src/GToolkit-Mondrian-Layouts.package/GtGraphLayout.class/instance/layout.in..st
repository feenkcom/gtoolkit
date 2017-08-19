layout
layout: anElement in: aRectangle

	self normalize: anElement in: aRectangle.
	
	anElement childrenDo: [ :child |
		child applyLayoutIn: child measuredBounds ]