actions
flush
	self 
		assert: [ theLog notNil ] 
		description: [ 'Flush method should be called after the log initialization' ].
	theLog store flush.