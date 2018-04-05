handling
handleScriptWithTokens: tokens
	| handler |
	scriptParameters := tokens second asDictionary.
	handler := GtDocumenterScriptHandler handlerForParameters: scriptParameters andTokens: tokens.
	handler new
		scriptParameters: scriptParameters;
		tokens: tokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		handle.