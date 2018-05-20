instance creation
newInspectorElement
	| view |
	view := GtPhlowExplicitView new.
	self codeSnippet value gtViewsFor: view.
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 160 ] ].