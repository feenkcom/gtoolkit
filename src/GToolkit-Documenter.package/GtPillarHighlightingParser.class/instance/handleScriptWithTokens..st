handling
handleScriptWithTokens: tokens
	| handlerClass handler codeSnippet scriptTokens |
	scriptTokens := GtPillarScriptTokens new.
	scriptTokens tokens: tokens.
	scriptIndex := scriptIndex + 1.
	codeSnippet := GtPillarScriptDetector new
		document: workspace;
		scriptIndex: scriptIndex;
		tokens: scriptTokens;
		find.
	handlerClass := GtDocumenterScriptHandler handlerForScript: scriptTokens.
	handler := handlerClass new.
	handler
		tokens: scriptTokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		workspace: codeSnippet;
		handle