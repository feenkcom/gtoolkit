accessing
parameters
	<return: #Array>
	self 
		assert: [ parameters notNil ] 
		description: [ 'You should not ask for parameters before the object initialization' ].
	^ parameters