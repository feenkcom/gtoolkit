accessing
document: aGtDocument
	self 
		assert: [ aGtDocument notNil ]
		description: [ 'Document has to be initialized' ].
	document := aGtDocument