instance creation
newInspectorElement
	| anInspectorElement |
	anInspectorElement := BlElement new.
	anInspectorElement
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	(self codeSnippet value respondsTo: #gtLiveIn:)
		ifTrue: [ self codeSnippet value gtLiveIn: anInspectorElement ]
		ifFalse: [ self codeSnippet value gtPrintIn: anInspectorElement ].
	^ anInspectorElement