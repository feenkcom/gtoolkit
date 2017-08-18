initialization
initializeElements
	"Initalize elements and add them as children.
	Note: Must be done only after attaching a GT-Example"
	
	self
		assert: [ editorElement isNil ]
		description: [ 'Editor element must not be initialized' ].
	self
		assert: [ arrowElement isNil ]
		description: [ 'Arrow element must not be initialized' ].

	editorElement := self newEditorElement: self example.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		"since parent is horizontal, I will take 50% of the available width"
		c grid horizontal weight: 0.5 ].
	
	arrowElement := self newArrowElement.
	arrowElement constraintsDo: [ :c |
		"Let's put arrow in the middle of its cell"
		c grid horizontal alignCenter.
		c grid vertical alignCenter ].
	
	previewElement := self newPreviewElement.
	previewElement constraintsDo: [ :c |
        c horizontal matchParent.
        c vertical matchParent.
        "since parent is horizontal, I will take 50% of the available width"
        c grid horizontal weight: 0.5 ].

	"we don't add previewElement by default"
	self addChildren: { editorElement . arrowElement }