file system
pillarDocumentWithEpiceaChanges
	<gtExample>
	<label: 'Pillar document with Epicea changes'>
	| fileReference |
	self directoryWithPillarAndEpiceaFiles.
	fileReference := fileSystemExamples pillarFileReference.
	self assert: fileReference exists.
	^ fileReference