accessing
previewHeight: anInteger
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Preview height parameter should be an integer' ].
	previewHeight := anInteger