handling
handleScriptWithTokens: tokens
	| handlerClass handler |
	scriptParameters := tokens second asDictionary.
	handlerClass := GtDocumenterScriptHandler handlerForParameters: scriptParameters andTokens: tokens.
	handler := handlerClass new.
	handler scriptParameters addAll: scriptParameters.
	handler	
		tokens: tokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		workspace: workspace;
		handle