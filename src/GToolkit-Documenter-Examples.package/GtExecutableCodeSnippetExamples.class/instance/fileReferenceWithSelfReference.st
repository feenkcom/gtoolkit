self reference
fileReferenceWithSelfReference
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithSelfReference.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference