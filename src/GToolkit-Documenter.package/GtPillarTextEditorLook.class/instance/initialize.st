initialization
initialize
	super initialize.
	self add: (BrLayoutLook constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ]).