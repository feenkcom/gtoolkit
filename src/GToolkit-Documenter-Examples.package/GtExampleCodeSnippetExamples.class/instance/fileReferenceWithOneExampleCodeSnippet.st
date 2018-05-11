simple example definition
fileReferenceWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Pillar file reference with an example code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithOneExampleCodeSnippet.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference