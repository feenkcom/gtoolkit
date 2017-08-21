scripting - shape
umlClassShapeWithName: aBlock andTextAttributes: aTextAttributesBlock
	self shape: [ :anObject |
		| label labelContainer contents grid labelText |
		labelText := BrRopedText string: (aBlock value: anObject).
		labelText attributes: (aTextAttributesBlock value: anObject).
		label := BlTextElement new
			text: labelText;
			padding: (BlInsets all: 5);
			constraintsDo: [ :c | c frame horizontal alignCenter ].
		labelContainer := BlElement new.
		labelContainer layout: BlFrameLayout new.
		labelContainer background: (BlBackground paint: Color white).
		labelContainer constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
		labelContainer addChild: label.
		contents := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ];
			background: Color white;
			beMondrianChildrenContainer.
	    grid := GtUMLClassElement new
			layout: (BlGridLayout vertical cellSpacing: 1);
			constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ];
			background: Color lightGray;
			addChildren: { labelContainer . contents } ]