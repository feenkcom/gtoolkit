utility
addPillarFileWithContent: aString
	^ self 
		addFileNamed: self pillarFileName 
		toDirectory: self rootDirectory 
		withContent: aString