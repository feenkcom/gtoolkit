initialization
initializeElements
	"Initalize elements and add them as children.
	Note: Must be done only after attaching a GT-Example"

	previewElement := self newPreviewElement.
	previewElement constraintsDo: [ :c |
		c horizontal matchParent.
		
		self hasCustomPreviewHeight
			ifTrue: [ c vertical exact: previewHeight ]
			ifFalse: [ c vertical matchParent ].
		"since parent is horizontal, I will take 50% of the available width"
		c linear weight: 0.5 ]