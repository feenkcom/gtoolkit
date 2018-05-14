instance creation
newBrowseGlobalChangesButtonModel
	| aModel |
	aModel := BrButtonModel new
		label: 'Edit';
		action: [ :theModel | self epiceaLog displayGlobalChanges: theModel ].
	^ aModel