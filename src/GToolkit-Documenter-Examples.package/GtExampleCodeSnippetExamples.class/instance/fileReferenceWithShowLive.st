example with show live parameter
fileReferenceWithShowLive
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with showLive'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithShowLive.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference