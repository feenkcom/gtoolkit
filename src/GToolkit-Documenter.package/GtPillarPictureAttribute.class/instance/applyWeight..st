accessing
applyWeight: anElement
	| containerElement |
	
	self isWeighted
		ifFalse: [ ^ anElement ].
	
	anElement constraintsDo: [ :c |
		c linear weight: self weight ].
	
	containerElement := BlElement new.
	containerElement layout: (BlLinearLayout horizontal weightSum: 1; alignCenter).
	containerElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c textFlow pushLine ].
	containerElement addChild: anElement.
	
	^ containerElement