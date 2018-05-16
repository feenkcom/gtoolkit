private
unsubscribeFromDocument: aGtDocument 
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
	aGtDocument isBinding ifFalse: [ ^ self ].
	aGtDocument systemChangesHandler unsubscribe: self.