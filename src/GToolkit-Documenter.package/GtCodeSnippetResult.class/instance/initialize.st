initialization
initialize
	super initialize.
	result := WorkspaceVariable named: GtDocumenterConstants resultVariableName.
	bindings := GtNoBindings uniqueInstance.