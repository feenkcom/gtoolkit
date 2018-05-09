document
documentWithSevenExecutableCodeSnippets
	<gtExample>
	<label: 'Pillar document with Script executor'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithSevenExecutableCodeSnippets.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument