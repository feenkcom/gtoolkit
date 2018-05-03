initialization
initialize
	super initialize.
	outs := GtCodeSnippetResults new.
	bindings := GtPlaygroundBindings new.
	bindings 
		addNamed: GtDocumenterConstants resultsVariableName 
		value: outs.