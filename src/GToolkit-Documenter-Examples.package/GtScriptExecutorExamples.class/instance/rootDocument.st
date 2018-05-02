document
rootDocument
	<gtExample>
	<label: 'Pillar document with Script executor'>
	| rootDirectory rootDocument |
	rootDirectory := self directoryWithDocuments.
	rootDocument := (rootDirectory / self pillarFileName).
	self assert: rootDocument exists.
	^ rootDocument