initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement padding: (BlInsets all: 2).
		anElement margin: (BlInsets all: 1). ]