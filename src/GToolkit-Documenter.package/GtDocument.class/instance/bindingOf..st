binding
bindingOf: aSymbol
	self 
		assert: [ aSymbol notNil ]
		description: [ 'The argument should be a symbol' ].
	^ bindings bindingOf: aSymbol