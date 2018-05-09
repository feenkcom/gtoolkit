default handler
defaultScriptHandler
	<gtExample>
	| typeClass |
	typeClass := GtPillarDefaultCodeSnippetType.
	self assert: (typeClass handlesScript: self defaultScriptTokens).
	^ typeClass