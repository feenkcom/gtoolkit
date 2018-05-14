class definition
fileReferenceWithClassDefinition
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with class definition'>
	| fileReference ombuFileReference |
	ombuFileReference := self ombuFileReferenceWithClassDefinition.
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithClassDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference