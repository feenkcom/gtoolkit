non-existent example method
fileReferenceWithNonExistentExampleMethod
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with non-existent example method'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleMethod.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference