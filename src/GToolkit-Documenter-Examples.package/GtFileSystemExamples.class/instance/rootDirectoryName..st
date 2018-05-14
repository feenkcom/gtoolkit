accessing
rootDirectoryName: aString
	self assert: aString isString description: 'The directory name has to be a string'.
	self 
		assert: [ (aString includes: self basicMemorySystem delimiter) not ]
		description: [ 'The directory name should not include ''', 
			self basicMemorySystem delimiter, ''' character' ].
	
	rootDirectoryName := aString