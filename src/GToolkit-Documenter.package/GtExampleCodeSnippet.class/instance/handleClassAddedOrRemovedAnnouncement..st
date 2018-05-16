announcement handling
handleClassAddedOrRemovedAnnouncement: aClassAnnouncement
	aClassAnnouncement classAffected name = self methodClassName ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)