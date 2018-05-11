accessing
shouldExpandPreview: aBoolean
	self 
		assert: [ aBoolean == true or: [ aBoolean == false ] ] 
		description: [ 'Should expand preview parameter should be a boolean' ].
	shouldExpandPreview := aBoolean