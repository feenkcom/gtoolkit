accessing
example: aGTExample showBlock: aPreviewShowBlock
	"Initialize me with a given GT-Example.
	With aPreviewShowBlock users can specify how GT-Examples result should be transformed into an element.
	aGTExample must not be nil.
	aPreviewShowBlock must not be nil"
	
	self
		assert: [ aGTExample isNotNil ]
		description: [ 'Example must not be nil' ].
		
	self
		assert: [ example isNil ]
		description: [ 'Can be initialized only once' ].
			
	self
		assert: [ aPreviewShowBlock isNotNil ]
		description: [ 'Transformation must not be nil' ].
		
	previewShowBlock := aPreviewShowBlock.
	example := aGTExample.

	self initializeElements.
	self initializeListeners