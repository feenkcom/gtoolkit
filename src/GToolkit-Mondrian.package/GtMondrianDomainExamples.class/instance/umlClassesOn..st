uml
umlClassesOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes
		umlClassShapeWithName: [ :each | each name ];
		for: (OrderedCollection withAllSubclasses) forEach: [ :class | 
			view nodes
				shape: [ :method | 
					BlTextElement new 
						text: (BrRopedText string: method selector);
						padding: (BlInsets top: 5 right: 5 bottom: 5 left: 5) ];
				for: class methods.
			view layout: BlLinearLayout vertical ].
	view edges connectFrom: #superclass.
	view layout: (GtGraphTreeLayout new verticalGap: 100). 
	^ view