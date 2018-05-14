actions
addEntryWith: anEpEvent tags: aBlockClosure
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file should exist' ].
	theLog addEntryWith: anEpEvent tags: aBlockClosure.