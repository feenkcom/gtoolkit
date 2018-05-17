announcement handling
handleEpEntryAddedAnnouncement: anEpEntryAdded 
	self announce: (
			GtEpiceaImpactChangedAnnouncement new hasImpact: true)