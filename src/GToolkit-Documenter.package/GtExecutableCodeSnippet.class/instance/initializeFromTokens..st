initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self label: aGtPillarScriptTokens labelParameterValue.