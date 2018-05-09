default handler
defaultScriptHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self defaultScriptTokens.
	self assert: handlerClass equals: GtPillarDefaultCodeSnippetType.
	^ handlerClass