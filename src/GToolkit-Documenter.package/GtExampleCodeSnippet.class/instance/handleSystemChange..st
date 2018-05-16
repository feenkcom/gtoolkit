announcement handling
handleSystemChange: aSystemAnnouncement 
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)