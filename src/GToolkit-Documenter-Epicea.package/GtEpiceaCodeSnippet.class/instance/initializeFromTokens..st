initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self assert: [ epiceaLog isNil ] description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: aGtPillarScriptTokens epiceaParameterValue.
	epiceaLog 
		subscribe: EpEntryAdded 
		send: #handleEpEntryAddedAnnouncement: 
		to: self 
		for: self.