instance creation
newInspectorElement
	| anInspectorElement |
	anInspectorElement := BlElement new.
	anInspectorElement
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	self codeSnippet value gtLiveIn: anInspectorElement.
	^ anInspectorElement