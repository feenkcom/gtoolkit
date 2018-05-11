example with expanded preview
fileReferenceWithExpandedPreview
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with expanded preview'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedPreview.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference