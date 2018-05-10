failed executable code snippet
fileReferenceWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithFailedExecutableCodeSnippet.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference