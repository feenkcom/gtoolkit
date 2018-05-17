accessing
announcer
	self 
		assert: [ theLog notNil ]
		description: [ 'Epicea log has to be initialized first. Then you can use the announcer' ].
	^ theLog announcer