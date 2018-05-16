announcement handling
handleClassAddedOrRemovedAnnouncement: aClassAnnouncement
	self methodClassName ifNil: [ ^ self ].
	((aClassAnnouncement classAffected name = self methodClassName) or: [ 
		aClassAnnouncement classAffected name = ('AnObsolete', self methodClassName) ]) 
			ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)