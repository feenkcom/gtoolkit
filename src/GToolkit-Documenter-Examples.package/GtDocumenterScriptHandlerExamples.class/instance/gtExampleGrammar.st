gt-examples
gtExampleGrammar
	<gtExample>
	| scriptTokensInArray |
	scriptTokensInArray := self parserInstance 
		targetText: self gtExamplePillarContent asRopedText;
		parse: self gtExamplePillarContent.
	self assert: scriptTokensInArray isCollection.
	self assert: scriptTokensInArray size equals: 1.
	self assert: scriptTokensInArray first class equals: GtPillarScriptTokens.
	^ scriptTokensInArray first.