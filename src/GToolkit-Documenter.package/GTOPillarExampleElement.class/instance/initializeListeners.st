initialization
initializeListeners
	"Initalize elements listeners such as arrow callback to show / hide preview.
	Note: Elements must be initalized before listeners!"
	
	self
		assert: [ arrowElement isNotNil ]
		description: [ 'Arrow element must exist' ].

	arrowElement
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent | self isPreviewShown
			ifTrue: [ self hidePreview ]
			ifFalse: [ self showPreview: previewShowBlock ] ]