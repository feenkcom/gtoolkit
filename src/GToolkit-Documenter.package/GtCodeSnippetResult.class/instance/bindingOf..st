binding
bindingOf: aSymbol
	"aSymbol is a variable name.
	Return a literal variable if the variable has a value assigned.
	Return nil, if the variable has no value assigned."
	<return: #LiteralVariable or: nil>
	self assert: [ aSymbol isSymbol ] description: [ 'Variable name should be a symbol' ].
	^ aSymbol = GtDocumenterConstants resultVariableName 
		ifTrue: [ self previousCodeSnippetResult ]
		ifFalse: [ bindings bindingOf: aSymbol ]