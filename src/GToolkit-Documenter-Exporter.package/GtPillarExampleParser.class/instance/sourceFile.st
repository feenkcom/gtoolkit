accessing
sourceFile
	self 
		assert: [ sourceFile notNil ] 
		description: [ 'Source file should be initialized first' ].
	^ sourceFile