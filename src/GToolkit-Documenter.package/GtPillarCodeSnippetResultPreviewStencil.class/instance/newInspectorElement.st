instance creation
newInspectorElement
	| anInspectorElement |
	anInspectorElement := BlPannableElement new.
	anInspectorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 300 ].
	anInspectorElement contentElement: self codeSnippet value gtViewsElement.
	^ anInspectorElement