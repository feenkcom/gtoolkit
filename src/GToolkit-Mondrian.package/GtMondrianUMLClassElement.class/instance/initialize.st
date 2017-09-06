initialization
initialize
	super initialize.
	label := BlTextElement new
		text: (BrRopedText string: '');
		padding: (BlInsets all: 5);
		constraintsDo: [ :c | c frame horizontal alignCenter ].
	labelContainer := BlElement new.
	labelContainer 
		layout: BlFrameLayout new;
		background: (BlBackground paint: Color white);
		border: (BlBorder paint: Color gray);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: label.
    self
		layout: (BlGridLayout vertical cellSpacing: 1);
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ];
		background: Color white;
		border: (BlBorder paint: Color gray);
		addChildren: { labelContainer }