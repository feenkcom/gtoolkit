handling
handleScriptWithTokens: tokens
	| handlerClass handler codeSnippet scriptTokens |
	scriptTokens := GtPillarScriptTokens new.
	scriptTokens tokens: tokens.
	handlerClass := GtDocumenterScriptHandler handlerForScript: scriptTokens.
	handler := handlerClass new.
	scriptIndex := scriptIndex + 1.
	codeSnippet := workspace scriptAt: scriptIndex.
	codeSnippet index: scriptIndex.
	handler
		tokens: scriptTokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		workspace: codeSnippet;
		handle