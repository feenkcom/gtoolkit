testing
handlesScript: aGtPillarScriptTokens
	^ aGtPillarScriptTokens hasExampleParameter and: [ 
		aGtPillarScriptTokens exampleParameterValue notNil ].