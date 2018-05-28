initialization
initialize
	super initialize.
	
	self previewStencil: self defaultPreviewStencilBuilder
	
	"self scriptParameters: Dictionary new."
	"self scriptParameters 
		at: self class showParameterName
		put: 'gtPrintIn:'"