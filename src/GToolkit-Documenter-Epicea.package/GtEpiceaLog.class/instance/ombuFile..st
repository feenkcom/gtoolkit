accessing
ombuFile: aFileReference
	ombuFile := aFileReference.
	theLog := EpLog freshFromFile: ombuFile.
	theLog announcer 
		when: EpEntryAdded do: [ :anAnnouncement | 
			self handleEpEntryAddedAnnouncement: anAnnouncement ].