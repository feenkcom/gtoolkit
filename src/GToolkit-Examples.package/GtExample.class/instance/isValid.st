testing
isValid
	self flag: 'Disabled the traversal check'.
	^ self hasProblems not
		"and: [ self traverser canProcess ]"