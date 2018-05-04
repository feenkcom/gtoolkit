editing document
directoryWithPillarContentAddingAndRemovingCodeSnippets
	<gtExample>
	<label: 'Directory with Pillar including script executors'>
	| rootDirectory rootDocument |
	rootDirectory := self rootDirectory.
	rootDocument := (rootDirectory / self pillarFileName) 
		writeStreamDo: [ :aStream | 
			aStream nextPutAll: self pillarContentAddingAndRemovingCodeSnippets ];
		yourself.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDirectory