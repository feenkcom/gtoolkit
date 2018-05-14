instance creation
newBrowseLogButtonModel
	| aModel |
	aModel := BrButtonModel new
		label: 'Browse';
		action: [ self epiceaLog browseEvents ].
	^ aModel