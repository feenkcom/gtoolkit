node creation
nestedNodesInDifferentContainers
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes 
		shape: [ :anObject |
			| label labelContainer contents1 contents2 grid |
			label := BlTextElement new
				text: (BrRopedText string: anObject asString);
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
			contents1 := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color yellow;
				padding: (BlInsets all: 5);
				beMondrianChildrenContainer: #one.
			contents2 := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color orange;
				padding: (BlInsets all: 5);
				beMondrianChildrenContainer: #two.
		    grid := GtWidthExpandingElement new
				layout: (BlGridLayout vertical cellSpacing: 1);
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color white;
				border: (BlBorder paint: Color gray);
				addChildren: { labelContainer . contents1 . contents2 } ];
		with: { 1 . 2 };
		forEach: [ :each | view nodes with: { 10 . 11 . 12 } ] in: #one;
		forEach: [ :each | view nodes with: { 20 . 21 } ] in: #two.
	view layout grid.
	^ view