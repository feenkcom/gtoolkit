private
ensureResult
	result ifNotNil: [ ^ self ].
	result := WorkspaceVariable named: GtDocumenterConstants resultVariableName.