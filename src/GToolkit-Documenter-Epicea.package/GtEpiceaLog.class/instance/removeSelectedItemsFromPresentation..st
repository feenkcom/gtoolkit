private
removeSelectedItemsFromPresentation: aGLMPresentation 
	| anOmbuEntry memoryStore entries |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	entries := (theLog entries reject: [ :eachEntry | eachEntry xdEquals: anOmbuEntry ]).
	ombuFile ensureDelete.
	entries do: [ :eachEntry | 
		theLog addEntryWith: eachEntry content tags: [ :tags |  ] ] 