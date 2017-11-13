initialization
initialize
	super initialize.
	self constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent. c padding: (BlInsets all: 20) ].
	self layout: (GtGraphHorizontalTreeLayout new horizontalGap: 100; verticalGap: 40).
	