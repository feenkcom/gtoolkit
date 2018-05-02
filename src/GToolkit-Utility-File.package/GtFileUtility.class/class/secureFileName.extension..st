accessing - file
secureFileName: fileNameStringOrNil extension: extensionString
	"Return a filename that is file system secure, e.g., does not include special characters"
	<return: #String>
	^ self 
		secureFileName: fileNameStringOrNil 
		extension: extensionString 
		maxLenght: GtFileUtilityConstants maxFileNameLenght