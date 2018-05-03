accessing
bindings: anObject
	self assert: [ anObject notNil ] description: [ 'Bindings should be an object' ].
	bindings := anObject