document
rootDocument
	<gtExample>
	<label: 'Pillar document with Script executor'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: self pillarContent.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument