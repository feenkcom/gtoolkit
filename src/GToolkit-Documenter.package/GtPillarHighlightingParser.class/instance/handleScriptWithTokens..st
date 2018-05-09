handling
handleScriptWithTokens: tokens
	| handlerClass handler codeSnippet scriptTokens type |
	scriptTokens := GtPillarScriptTokens new.
	scriptTokens tokens: tokens.
	scriptIndex := scriptIndex + 1.
	codeSnippet := GtCodeSnippetFinder new
		document: workspace;
		scriptIndex: scriptIndex;
		tokens: scriptTokens;
		find.
	type := GtPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
	handlerClass := type brickHandlerClass.
	handler := handlerClass new.
	handler
		tokens: scriptTokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		codeSnippet: codeSnippet;
		handle.
	 ^ scriptTokens