instance creation
newCodeSnippetAtSameIndex
	| type newScript |
	type := GtPillarCodeSnippetDetector typeForScriptTokens: self tokens.
	newScript := type codeSnippetClass new.
	newScript index: self scriptIndex.
	newScript sourceCode: self sourceCode.
	newScript document: self document.
	newScript initializeFromTokens: self tokens.
	^ newScript