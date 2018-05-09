script executor
executableScriptHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self executableScriptTokens.
	self assert: handlerClass equals: GtPillarExecutableCodeSnippetType.
	^ handlerClass