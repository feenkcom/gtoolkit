enumerating
typeForScriptTokens: aGtPillarScriptTokens
	<return: #GtPillarScriptHandler>
	self assert: [ aGtPillarScriptTokens notNil ] description: [ 'Tokens has to be defined' ].
	^ (self typesForScriptTokens: aGtPillarScriptTokens) first