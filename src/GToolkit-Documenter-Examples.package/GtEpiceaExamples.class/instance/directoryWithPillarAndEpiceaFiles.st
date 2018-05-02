file system
directoryWithPillarAndEpiceaFiles
	<gtExample>
	<label: 'Directory with Pillar and Epicea files'>
	| rootDirectory rootDocument epiceaDir stepOne stepTwo |
	rootDirectory := self rootDirectory.
	rootDocument := (rootDirectory / self pillarFileName) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self pillarContent ];
		yourself.
	epiceaDir := (rootDirectory / self epiceaDirectoryFileName) ensureCreateDirectory; yourself.
	stepOne := (epiceaDir / self epiceaStepOneFileName) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self epiceaStepOneContent ];
		yourself.
	stepTwo := (epiceaDir / self epiceaStepTwoFileName) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self epiceaStepTwoContent ];
		yourself.
	self assert: rootDocument exists.
	self assert: epiceaDir exists.
	self assert: stepOne exists.
	self assert: stepTwo exists.
	^ rootDirectory