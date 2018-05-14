empty definition
fileReferenceWithEmptyDefinition
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with empty definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference