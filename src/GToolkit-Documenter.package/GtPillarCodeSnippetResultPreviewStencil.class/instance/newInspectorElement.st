instance creation
newInspectorElement
	^ self codeSnippet value gtViewsElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 300 ].