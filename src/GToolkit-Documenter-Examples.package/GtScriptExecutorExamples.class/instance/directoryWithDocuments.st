document
directoryWithDocuments
	<gtExample>
	<label: 'Directory with Pillar including script executor'>
	| rootDirectory rootDocument |
	rootDirectory := self rootDirectory.
	rootDocument := (rootDirectory / self pillarFileName) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self pillarContent ];
		yourself.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDirectory