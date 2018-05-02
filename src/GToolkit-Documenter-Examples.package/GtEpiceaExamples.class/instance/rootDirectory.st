file system
rootDirectory
	<gtExample>
	<label: 'Working directory of a memory file system'>
	directory ifNil: [ directory := self basicMemorySystem 
		workingDirectory / UUID new asString asFileName ].
	self assert: directory exists not.
	directory ensureCreateDirectory.
	self assert: directory exists.
	"Only root directory should be present"
	self assert: directory allChildren size equals: 1.
	^ directory