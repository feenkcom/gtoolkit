file system
rootDirectory
	<gtExample>
	<label: 'Working directory of a memory file system'>
	^ rootDirectoryName 
		ifNil: [ self basicMemorySystem workingDirectory ]
		ifNotNil: [ (self basicMemorySystem workingDirectory / rootDirectoryName)
			ensureCreateDirectory ]