file system
directoryWithPillarAndEpiceaFiles
	<gtExample>
	<label: 'Directory with Pillar and Epicea files'>
	| rootDocument epiceaDir stepOne stepTwo |
	rootDocument := fileSystemExamples addPillarFileWithContent: self pillarContent.
	epiceaDir := (fileSystemExamples rootDirectory / self epiceaDirectoryFileName).
	epiceaDir ensureCreateDirectory.
	stepOne := fileSystemExamples 
		addFileNamed: self epiceaStepOneFileName 
		toDirectory: epiceaDir 
		withContent: self epiceaStepOneContent.
	stepTwo := fileSystemExamples 
		addFileNamed: self epiceaStepTwoFileName 
		toDirectory: epiceaDir 
		withContent: self epiceaStepTwoContent.
	self assert: rootDocument exists.
	self assert: epiceaDir exists.
	self assert: stepOne exists.
	self assert: stepTwo exists.
	^ fileSystemExamples rootDirectory