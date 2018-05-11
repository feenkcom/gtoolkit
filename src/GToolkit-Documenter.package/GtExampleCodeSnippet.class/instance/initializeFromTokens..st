initialization
initializeFromTokens: aGtPillarScriptTokens
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self methodName: aGtPillarScriptTokens exampleParameterValue.
	aGtPillarScriptTokens hasShowParameter  
		ifTrue: [ self showMessageName: aGtPillarScriptTokens showParameterValue ].
	aGtPillarScriptTokens isPreviewHeightDefined ifTrue: [ 
		self previewHeight: aGtPillarScriptTokens heightParameterValue ].
	self shouldDisplayCode: aGtPillarScriptTokens shouldDisplayCode.
	self shouldExpandPreview: aGtPillarScriptTokens shouldExpandPreview.