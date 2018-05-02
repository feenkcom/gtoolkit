initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement border: (BlBorder paint: Color veryLightGray width: 1).
		anElement padding: (BlInsets all: 3).
		anElement margin: (BlInsets all: 3). ]