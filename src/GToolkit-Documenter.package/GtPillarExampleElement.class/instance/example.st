accessing
example
	"Return assigned gt example that can not be nil"
	<return: #GtExample>
	
	self
		assert: [ example isNotNil ]
		description: [ 'Can not access unexisting example' ].

	^ example