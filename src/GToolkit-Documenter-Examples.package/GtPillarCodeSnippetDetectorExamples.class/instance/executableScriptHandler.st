script executor
executableScriptHandler
	<gtExample>
	| typeClass |
	typeClass := GtPillarExecutableCodeSnippetType.
	self assert: (typeClass handlesScript: self executableScriptTokens).
	^ typeClass