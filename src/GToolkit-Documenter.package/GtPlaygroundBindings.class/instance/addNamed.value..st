adding
addNamed: aSymbol value: anObject 
	self assert: [ aSymbol isSymbol ] description: [ 'Variable name should be a symbol' ].
	bindings 
		at: aSymbol 
		put: ((WorkspaceVariable named: aSymbol) value: anObject)