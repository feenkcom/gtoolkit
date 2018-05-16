private
subscribeToDocument: aGtDocument 
	"Subclasses can register for document and system changes."
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].