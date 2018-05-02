announcement handling
handleSystemChange: aSystemAnnouncement
	self isValid ifFalse: [ ^ self ].
	self checkImpact.
	self announcer announce: (
			GtEpiceaImpactChangedAnnouncement new hasImpact: self hasImpact)