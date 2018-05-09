instance creation
newCodeSnippetAtSameIndex
	| handler newScript |
	handler := GtDocumenterScriptHandler handlerForScript: self tokens.
	newScript := handler codeSnippetClass new.
	newScript index: self scriptIndex.
	newScript sourceCode: self sourceCode.
	newScript document: self document.
	^ newScript