adding
addVariableBinding: anAssociation 
	bindings 
		at: anAssociation key 
		put: (WorkspaceVariable key: anAssociation key value: anAssociation value)