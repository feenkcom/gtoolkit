binding
bindingOf: aSymbol
	<return: #LiteralVariable or: nil>
	| assocOrNil |
	self assert: [ aSymbol isSymbol ] description: [ 'Bindings should be referenced by a symbol' ].
	assocOrNil := bindings bindingOf: aSymbol.
	^ self treatBinding: assocOrNil of: aSymbol.
	