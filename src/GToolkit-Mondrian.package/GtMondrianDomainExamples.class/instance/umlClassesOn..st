uml
umlClassesOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes
		umlClassShapeWithName: [ :each | each name ];
		with: OrderedCollection withAllSubclasses
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
				for: class methods.
			view layout custom: BlLinearLayout vertical ].
	view edges connectFrom: #superclass.
	view layout tree verticalGap: 100.
	^ view