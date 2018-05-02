accessing - file
shorterNameForFileName: aFileNameString 
	<return: #String>
	| aFileReference fromWorkingDir fromHomeDir |
	aFileReference := aFileNameString asFileReference.
	aFileReference exists ifFalse: [ ^ aFileNameString ]. 
	fromWorkingDir := self fileNameOf: aFileReference relativeTo: FileLocator workingDirectory asAbsolute.
	fromHomeDir := self fileNameOf: aFileReference relativeTo: FileLocator home asAbsolute.
	^ fromWorkingDir size < fromHomeDir size
		ifTrue: [ fromWorkingDir ]
		ifFalse: [ fromHomeDir ]