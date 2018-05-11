initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	aGtPillarScriptTokens hasShowParameter  
		ifTrue: [ self showMessage: aGtPillarScriptTokens showParameterValue ].
	self methodName: aGtPillarScriptTokens exampleParameterValue