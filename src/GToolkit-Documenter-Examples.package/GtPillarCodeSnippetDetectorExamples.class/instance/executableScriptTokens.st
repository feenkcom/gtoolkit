script executor
executableScriptTokens
	<gtExample>
	<return: #GtPillarScriptTokens>
	| scriptTokens |
	scriptTokens := self scriptTokensFor: self executableScriptPillarContent.
	self assert: scriptTokens hasParameters not.
	self 
		assert: scriptTokens scriptBodyString 
		equals: 'self traceCr: ''test''.
'.
	^ scriptTokens.