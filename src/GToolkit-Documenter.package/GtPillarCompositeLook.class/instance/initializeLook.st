initialization
initializeLook
	super initializeLook.

	self widgetDo: [ :anElement | 
		anElement border: (BlBorder paint: Color veryLightGray width: 1).
		anElement outskirts: BlOutskirts outside.
		anElement padding: (BlInsets all: 3).
		anElement margin: (BlInsets all: 3) ]