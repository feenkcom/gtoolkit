accessing
document: aGtDocument 
	bindings ifNotNil: [ :anOldDocument | self unsubscribeFromDocument: anOldDocument ].
	bindings := aGtDocument.
	aGtDocument addCodeSnippet: self.
	self subscribeToDocument: aGtDocument