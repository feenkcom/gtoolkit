accessing
exception: anException
	self 
		assert: [ anException isNotNil ] 
		description: [ 'Exception has to be initialized' ].
	exception := anException