handling
handleScriptWithTokens: tokens
	| handler |
	scriptParameters := tokens second asDictionary.
	handler := GtDocumenterScriptHandler handlerForParameters: scriptParameters andTokens: tokens.
	handler handle: scriptParameters withTokens: tokens andTargetText: self targetText.