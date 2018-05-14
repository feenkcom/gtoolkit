private
insertSelectedItemsFromPresentation: aGLMPresentation 
	| anOmbuEntry |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	self addEntryWith: anOmbuEntry content tags: [ :tags |  ].