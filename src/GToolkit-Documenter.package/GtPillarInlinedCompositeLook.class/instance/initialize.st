initialization
initialize
	super initialize.
	self add: (BrLayoutLook linearHorizontal
		constraintsDo: [ :c |
			c linear vertical alignCenter.
			c horizontal fitContent.
			c vertical fitContent ]).