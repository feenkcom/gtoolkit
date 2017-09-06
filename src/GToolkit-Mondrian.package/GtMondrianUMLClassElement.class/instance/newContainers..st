accessing
newContainers: aCollectionOfSymbols
	aCollectionOfSymbols do: [ :each |
		self addChild: (BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ];
			background: Color white;
			padding: (BlInsets all: 5);
			beMondrianChildrenContainer: each) ]