initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	self 
		assert: [ aGtPillarScriptTokens isNotNil ]
		description: [ 'Pillar script tokens should be initialized' ]