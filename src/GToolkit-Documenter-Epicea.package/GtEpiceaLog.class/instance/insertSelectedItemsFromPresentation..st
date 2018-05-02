private
insertSelectedItemsFromPresentation: aGLMPresentation 
	| anOmbuEntry |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	theLog addEntryWith: anOmbuEntry content tags: [ :tags |  ].