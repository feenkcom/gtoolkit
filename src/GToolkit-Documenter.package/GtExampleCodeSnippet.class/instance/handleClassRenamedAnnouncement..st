announcement handling
handleClassRenamedAnnouncement: aSystemAnnouncement 
	"self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)"