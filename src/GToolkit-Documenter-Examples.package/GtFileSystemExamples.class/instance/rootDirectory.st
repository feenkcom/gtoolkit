file system
rootDirectory
	<gtExample>
	<label: 'Working directory of a memory file system'>
	| directory |
	directory := self basicMemorySystem workingDirectory.
	"Only root directory should be present"
	self assert: directory allChildren size equals: 1.
	^ directory