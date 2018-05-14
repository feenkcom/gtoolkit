class definition
ombuFileReferenceWithClassDefinition
	<gtExample>
	<label: 'File reference of epicea changes with a class definition'>
	^ fileSystemExamples 
			addFileNamed: self epiceaFileNameWithClassDefinition
			toDirectory: self epiceaChangeDirectory 
			withContent: self epiceaContentWithClassDefinition.