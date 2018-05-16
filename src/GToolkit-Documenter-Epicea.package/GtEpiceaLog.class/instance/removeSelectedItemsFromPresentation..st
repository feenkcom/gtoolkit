private
removeSelectedItemsFromPresentation: aGLMPresentation 
	| anOmbuEntry entries |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	entries := (theLog entries reject: [ :eachEntry | eachEntry xdEquals: anOmbuEntry ]).
	ombuFile ensureDelete.
	entries do: [ :eachEntry | 
		self addEntryWith: eachEntry content tags: [ :tags |  ] ] 