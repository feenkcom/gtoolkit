announcement handling
handleMethodAnnouncement: aMethodModified 
	((aMethodModified classAffected name = self methodClassName) and: [ 
		aMethodModified selector = self methodSelectorName ]) ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)