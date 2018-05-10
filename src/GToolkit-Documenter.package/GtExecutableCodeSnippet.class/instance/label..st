accessing
label: aString
	self 
		assert: [ aString isString ] 
		description: [ 'Label should be an instance of String' ].
	label := aString