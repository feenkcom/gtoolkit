public
closeMethod: aMethod

	self
		assert: [ self hasOpenedMethod: aMethod ]
		description: [ 'Method must be opened' ].

	self
		elementWithMethod: aMethod
		ifPresent: [ :aMethodElement |
			self removeEdgesFrom: aMethodElement.
			"as soon as method element is removed, lines will automatically disappear"
			aMethodElement removeFromParent ]