initialization
initialize
	super initialize.
	self constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent. c padding: (BlInsets all: 40) ].
	self layout: (GtGraphHorizontalDominanceTreeLayout new horizontalGap: 100; verticalGap: 40)