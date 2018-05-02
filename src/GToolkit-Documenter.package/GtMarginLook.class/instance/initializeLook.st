initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement margin: insets. ]