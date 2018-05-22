accessing
tokens: aGtPillarScriptTokens 
	super tokens: aGtPillarScriptTokens.
	self 
		assert: [ epiceaLog isNil ] 
		description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: aGtPillarScriptTokens epiceaParameterValue.
	