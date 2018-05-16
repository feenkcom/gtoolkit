initialization
initialize
	super initialize.
	self add: (BrLayoutLook linearVertical 
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c vertical fitContentLimited.
			c horizontal matchParent ]).