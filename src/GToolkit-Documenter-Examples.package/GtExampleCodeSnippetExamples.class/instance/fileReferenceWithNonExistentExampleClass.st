non-existent example class
fileReferenceWithNonExistentExampleClass
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with non-existent example class'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleClass.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference