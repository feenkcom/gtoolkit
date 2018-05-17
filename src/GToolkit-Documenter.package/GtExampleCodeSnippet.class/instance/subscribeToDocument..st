private
subscribeToDocument: aGtDocument 
	super subscribeToDocument: aGtDocument.
	aGtDocument systemChangesHandler
		subscribe: MethodAdded, MethodModified, MethodRemoved
		send: #handleMethodAnnouncement:
		to: self.
	aGtDocument systemChangesHandler
		subscribe: ClassAdded, ClassRemoved
		send: #handleClassAddedOrRemovedAnnouncement:
		to: self.
	aGtDocument systemChangesHandler
		subscribe: ClassRenamed
		send: #handleClassRenamedAnnouncement:
		to: self.