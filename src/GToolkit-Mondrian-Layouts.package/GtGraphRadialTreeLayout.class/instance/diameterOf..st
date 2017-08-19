algorithm
diameterOf: aNode

	|diam|
	
	(false "aNode shapes first isKindOf: RTEllipse") ifTrue: [ diam := aNode width max: aNode height ]
										ifFalse: [ diam := (aNode width * aNode width + (aNode height * aNode height)) sqrt floor ].
	
	^ diam