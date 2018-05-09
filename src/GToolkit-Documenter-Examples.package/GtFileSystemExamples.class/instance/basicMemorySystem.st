file system
basicMemorySystem
	<gtExample>
	<label: 'Basic Memory File System'>
	memory ifNil: [
		 memory := FileSystem memory.
		"Only root '/' should be present"
		self assert: memory root allChildren size equals: 1 ].
	^ memory