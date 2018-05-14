initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	epiceaLog := GtEpiceaLog fromFileReference: aGtPillarScriptTokens epiceaParameterValue.
	