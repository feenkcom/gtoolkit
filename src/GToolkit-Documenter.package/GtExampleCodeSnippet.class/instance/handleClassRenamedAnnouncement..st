announcement handling
handleClassRenamedAnnouncement: aClassAnnouncement
	((aClassAnnouncement newName = self methodClassName) or: [ 
		aClassAnnouncement oldName = self methodClassName ]) ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)