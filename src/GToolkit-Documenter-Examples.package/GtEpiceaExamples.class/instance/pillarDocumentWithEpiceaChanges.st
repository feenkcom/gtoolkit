file system
pillarDocumentWithEpiceaChanges
	<gtExample>
	<label: 'Pillar document with Epicea changes'>
	| rootDirectory rootDocument |
	rootDirectory := self directoryWithPillarAndEpiceaFiles.
	rootDocument := (rootDirectory / self pillarFileName).
	self assert: rootDocument exists.
	^ rootDocument