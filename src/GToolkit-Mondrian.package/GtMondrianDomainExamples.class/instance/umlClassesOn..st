uml
umlClassesOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view umlClassShapeWithName: [ :each | each name ].
	view nodes: (OrderedCollection withAllSubclasses) forEach: [ :class | 
		view shape: [ :method | 
			BlTextElement new 
				text: (BrRopedText string: method selector);
				padding: (BlInsets top: 5 right: 5 bottom: 5 left: 5) ].
		view nodes: class methods.
		view layout: BlLinearLayout vertical ].
	view edges connectFrom: #superclass.
	view layout: (GtGraphTreeLayout new verticalGap: 100). 
	^ view