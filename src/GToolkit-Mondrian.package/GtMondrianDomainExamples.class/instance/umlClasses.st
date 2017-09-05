uml
umlClasses
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		umlClassShapeWithName: [ :each | each name ];
		with: OrderedCollection withAllSubclasses;
		forEach: [ :class | 
			view nodes
				shape: [ :method | 
					BlTextElement new
						text: (BrRopedText string: method selector);
						padding:
							(BlInsets
								top: 5
								right: 5
								bottom: 5
								left: 5) ];
				with: class methods.
			view layout custom: BlLinearLayout vertical ].
	view edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: #superclass.
	view layout tree verticalGap: 100.
	^ view