layout
boundingBox: anElement
	anElement children isEmpty ifTrue: [ ^ ((0 @ 0) corner: (0 @ 0)) ].
	
	^ anElement children inject: nil into: [ :rectangle :child |
		rectangle ifNil: [ child measuredBounds ] ifNotNil: [ :r | r quickMerge: child measuredBounds ] ]