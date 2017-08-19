reversing
inverseAttachPoint
	"Invert the attach point of all the considered edges. It is likely that all the attachpoint are the same, but we do not have a garanty"
	
	self flag: 'Attach point'.
	
	"| a |
	a := RTShorterHorizontalDistanceAttachPoint new.
	edges
		do: [ :edge | 
			edge shape attachPoint: a.
			edge updateFromTo ]
"