initialization
initialize
	super initialize.
	codeSnippets := GtCodeSnippets new.
	bindings := GtPlaygroundBindings new.
	bindings 
		addNamed: GtDocumenterConstants resultsVariableName 
		value: codeSnippets.
	systemChangesHandler := GtSystemChangesHandler forDocument: self.