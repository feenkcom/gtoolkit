binding
bindingOf: aSymbol
	^ bindings
		at: aSymbol 
		ifPresent: [ :aValue | aValue ] 
		ifAbsentPut: [ 
			bindings at: aSymbol put: (WorkspaceVariable key: aSymbol value: nil) ]