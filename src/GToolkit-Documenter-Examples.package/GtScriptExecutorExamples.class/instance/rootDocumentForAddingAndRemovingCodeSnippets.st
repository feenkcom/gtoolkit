editing document
rootDocumentForAddingAndRemovingCodeSnippets
	<gtExample>
	<label: 'Pillar document with Script executors'>
	| rootDirectory rootDocument |
	rootDirectory := self directoryWithPillarContentAddingAndRemovingCodeSnippets.
	rootDocument := (rootDirectory / self pillarFileName).
	self assert: rootDocument exists.
	^ rootDocument