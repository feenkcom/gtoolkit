accessing
text
	self
		assert: [ epiceaLog notNil ]
		description: [ 'Epicea log has to be initialized first' ].
	^ epiceaLog newStateString 