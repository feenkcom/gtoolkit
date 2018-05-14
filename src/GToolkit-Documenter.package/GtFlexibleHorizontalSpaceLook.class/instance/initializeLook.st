initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 1 ]. ]