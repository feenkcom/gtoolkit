accessing
previewStencil: aPreviewStencilBuilder
	"Set a builder responsible for creating a preview stencil that instanciates an element used
	to visually represent snippet result.
	
	aPreviewStencilBuilder can be a block closure of the following form:
	[ :aCodeSnippet :aBrEditorElement :aBrText | 'create preview here' ]

	"

	previewStencilBuilder := aPreviewStencilBuilder asStencilBuilder: GtPillarBrickStencilBuilder