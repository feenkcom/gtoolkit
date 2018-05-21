accessing
tokens: aGtPillarScriptTokens 
	self 
		assert: [ aGtPillarScriptTokens notNil ] 
		description: [ 'Pillar codeblock tokens should be initialized' ].
	tokens := aGtPillarScriptTokens.
	self parameters: aGtPillarScriptTokens parameters.
	self text: aGtPillarScriptTokens scriptBodyString