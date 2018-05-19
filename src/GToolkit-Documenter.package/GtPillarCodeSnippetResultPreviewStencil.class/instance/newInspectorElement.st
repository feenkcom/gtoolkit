instance creation
newInspectorElement
	| view |
	view := GtPhlowView new.
	self codeSnippet value gtViewsFor: view.
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 160 ] ].