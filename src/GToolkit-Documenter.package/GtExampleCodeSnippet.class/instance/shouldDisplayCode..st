accessing
shouldDisplayCode: aBoolean
	self 
		assert: [ aBoolean == true or: [ aBoolean == false ] ] 
		description: [ 'Should display code parameter should be a boolean' ].
	shouldDisplayCode := aBoolean