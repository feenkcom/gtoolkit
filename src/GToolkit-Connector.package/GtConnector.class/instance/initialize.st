initialization
initialize
	super initialize.
	self constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ].
	self layout: (GtGraphHorizontalTreeLayout new horizontalGap: 100; layered).
	