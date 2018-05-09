utility
addFileNamed: fileNameString withContent: aString
	^ self 
		addFileNamed: fileNameString 
		toDirectory: self rootDirectory 
		withContent: aString