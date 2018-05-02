binding
bindingOf: aSymbol
	^ bindings
		at: aSymbol 
		ifPresent: [ :aValue | aValue ] 
		ifAbsent: [ nil ]