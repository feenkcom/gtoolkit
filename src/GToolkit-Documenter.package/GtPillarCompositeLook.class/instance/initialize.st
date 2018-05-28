initialization
initialize
	super initialize.
	self add: (BrLayoutLook linearVertical 
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical exact: 200 ])