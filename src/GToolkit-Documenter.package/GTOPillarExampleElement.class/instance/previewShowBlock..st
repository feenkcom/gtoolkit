accessing
previewShowBlock: aBlockOrSymbol
	"Specify how GT-Examples result should be transformed into an element.
	aBlockOrSymbol must not be nil"
	
	self
		assert: [ aBlockOrSymbol isNotNil ]
		description: [ 'Transformation must not be nil' ].
		
	previewShowBlock := aBlockOrSymbol