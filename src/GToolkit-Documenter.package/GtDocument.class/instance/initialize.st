initialization
initialize
	super initialize.
	outs := GtCodeSnippets new.
	bindings := GtPlaygroundBindings new.
	bindings 
		addNamed: GtDocumenterConstants resultsVariableName 
		value: outs.