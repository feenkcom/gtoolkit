testing
hasProblems
	self flag: 'Disabled the dependencoes checks for now'.
	^ problems notEmpty
		"or: [ self hasValidArguments not
			or: [  self hasValidAfter not
				or: [ self hasValidDependencies not ] ] ]"