utility
scriptTokensFor: aString
	<return: #GtPillarScriptTokens>
	| scriptTokensInArray scriptTokens |
	scriptTokensInArray := self parserInstance 
		targetText: aString asRopedText;
		parse: aString.
	self assert: scriptTokensInArray isCollection.
	self assert: scriptTokensInArray size equals: 1.
	self assert: scriptTokensInArray first class equals: GtPillarScriptTokens.
	scriptTokens := scriptTokensInArray first.
	^ scriptTokens.