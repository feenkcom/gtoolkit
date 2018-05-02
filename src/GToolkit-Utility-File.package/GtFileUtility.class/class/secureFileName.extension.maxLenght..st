accessing - file
secureFileName: fileNameStringOrNil extension: extensionString maxLenght: anInteger
	"Return a filename that is file system secure, e.g., does not include special characters"
	<return: #String>
	| basename |
	fileNameStringOrNil ifNil: [ ^ 'xd-file.', extensionString ].
	basename := String 
		streamContents: [ :aStream | | previousCharacter |
			previousCharacter := nil.
			fileNameStringOrNil do: [ :eachCharacter | 
				eachCharacter isAlphaNumeric 
					ifTrue: [ aStream nextPut: eachCharacter asLowercase ]
					ifFalse: [ previousCharacter = self secureCharacter 
						ifFalse: [ aStream nextPut: self secureCharacter ] ].
				previousCharacter := eachCharacter ]
			 ] 
		limitedTo: anInteger.
	^ basename, '.', extensionString