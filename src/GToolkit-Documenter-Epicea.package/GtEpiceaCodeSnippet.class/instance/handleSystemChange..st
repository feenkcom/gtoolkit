system changes
handleSystemChange: aSystemAnnouncement
	self epiceaLog isValid ifFalse: [ ^ self ].
	self epiceaLog checkImpact.
	self announce: (
			GtEpiceaImpactChangedAnnouncement 
				document: self document 
				codeSnippet: self 
				withImpact: self epiceaLog hasImpact)