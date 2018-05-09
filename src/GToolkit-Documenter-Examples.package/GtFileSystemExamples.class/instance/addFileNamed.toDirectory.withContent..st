utility
addFileNamed: fileNameString toDirectory: rootDirectory withContent: aString
	| rootDocument |
	rootDocument := (rootDirectory / fileNameString) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: aString ];
		yourself.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument