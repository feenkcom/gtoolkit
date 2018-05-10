accessing
document: aGtDocument
	self assert: [ aGtDocument isNotNil ] description: [ 'Document has to be initialized' ].
	document := aGtDocument