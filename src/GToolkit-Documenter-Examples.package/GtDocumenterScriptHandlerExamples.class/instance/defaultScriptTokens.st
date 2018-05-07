default handler
defaultScriptTokens
	<gtExample>
	<return: #GtPillarScriptTokens>
	| scriptTokens parameterValue |
	scriptTokens := self scriptTokensFor: self defaultPillarContent.
	self assert: scriptTokens hasParameters.
	parameterValue := scriptTokens valueOf: #parameterOne emptyValue: nil defaultValue: nil.
	self assert: parameterValue equals: 'Value One'.
	parameterValue := scriptTokens valueOf: #parameterTwo emptyValue: nil defaultValue: nil.
	self assert: parameterValue equals: 'Value Two'.
	self 
		assert: scriptTokens scriptBodyString 
		equals: ''.
	^ scriptTokens.