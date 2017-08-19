accessing
weight: aNumber

	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Weight must be normalized!' ].
		
	self
		assert: [ weight isNil ]
		description: [ 'Weight can be set only once' ].

	weight := aNumber