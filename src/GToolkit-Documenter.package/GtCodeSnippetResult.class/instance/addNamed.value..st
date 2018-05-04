adding
addNamed: aSymbol value: anObject 
	"Set bindings for a variable named aSymbol and value anObject."
	self assert: [ aSymbol isSymbol ] description: [ 'Variable name should be a symbol' ].
	aSymbol = GtDocumenterConstants resultVariableName
		ifTrue: [ self value: anObject ]
		ifFalse: [ bindings addNamed: aSymbol value: anObject ]