accessing
example: aGTExample
	"Initialize me with a given GT-Example.
	aGTExample must not be nil"
	
	self
		assert: [ aGTExample isNotNil ]
		description: [ 'Example must not be nil' ].
		
	self
		assert: [ example isNil ]
		description: [ 'Can be initialized only once' ].
		
	example := aGTExample.

	self initializeElements.
	self initializeListeners