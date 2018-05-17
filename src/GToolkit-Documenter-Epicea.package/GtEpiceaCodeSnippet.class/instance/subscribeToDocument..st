private
subscribeToDocument: aGtDocument 
	super subscribeToDocument: aGtDocument.
	aGtDocument systemChangesHandler
		subscribe: ClassAnnouncement, MethodAnnouncement
		send: #handleSystemChange:
		to: self.