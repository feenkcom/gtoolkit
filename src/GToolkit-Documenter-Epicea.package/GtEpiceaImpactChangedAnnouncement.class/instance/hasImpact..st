accessing
hasImpact: aBoolean
	self 
		assert: [ aBoolean = true or: [ aBoolean = false ] ]
		description: 'Value has to be a boolean.'.
	hasImpact := aBoolean