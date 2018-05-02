instance creation
newBrowseLogButtonModel
	| aModel |
	aModel := BrButtonModel new
		label: 'Browse';
		action: [ epiceaLog browseEvents ].
	^ aModel