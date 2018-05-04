instance creation
newCodeSnippetAtSameIndex
	| newScript |
	newScript := GtCodeSnippetResult new.
	newScript index: self scriptIndex.
	newScript sourceCode: self sourceCode.
	newScript document: self document.
	^ newScript