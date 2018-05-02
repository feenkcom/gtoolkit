initialization
initializeLook
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement background: Color white.
		anElement padding: (BlInsets all: 2).
		"anElement border: (BlBorder paint: Color veryLightGray width: 1)" ]