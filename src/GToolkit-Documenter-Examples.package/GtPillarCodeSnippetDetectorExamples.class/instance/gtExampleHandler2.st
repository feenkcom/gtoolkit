gt-examples
gtExampleHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self gtExampleScriptTokens.
	self assert: handlerClass equals: GtPillarExampleCodeSnippetType.
	^ handlerClass