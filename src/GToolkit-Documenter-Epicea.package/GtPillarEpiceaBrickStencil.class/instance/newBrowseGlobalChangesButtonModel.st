instance creation
newBrowseGlobalChangesButtonModel
	^ BrButtonModel new
		label: 'Edit';
		action: [ :theModel | self epiceaLog displayGlobalChanges: theModel ]