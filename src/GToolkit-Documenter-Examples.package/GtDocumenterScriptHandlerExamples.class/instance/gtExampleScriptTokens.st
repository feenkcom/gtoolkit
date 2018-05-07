gt-examples
gtExampleScriptTokens
	<gtExample>
	<return: #GtPillarScriptTokens>
	| scriptTokens |
	scriptTokens := self scriptTokensFor: self gtExamplePillarContent.
	self assert: scriptTokens hasExampleParameter.
	self 
		assert: scriptTokens exampleParameterValue 
		equals: 'GtDocumenterErrorExamples>>#nonExistentMethod'.
	^ scriptTokens.