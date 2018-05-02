announcement handling
handleEpEntryAddedAnnouncement: anEpEntryAdded 
	self announcer announce: (
			GtEpiceaImpactChangedAnnouncement new hasImpact: true)