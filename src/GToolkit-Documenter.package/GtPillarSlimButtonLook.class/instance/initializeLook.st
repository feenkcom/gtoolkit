initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement padding: (BlInsets all: 1).
		anElement margin: (BlInsets all: 2). ]