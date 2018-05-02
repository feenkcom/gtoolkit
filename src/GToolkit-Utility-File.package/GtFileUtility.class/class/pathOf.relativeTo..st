accessing - file
pathOf: aFileReference relativeTo: directoryFileReference
	<return: #Path>
	^ (aFileReference relativeToReference: directoryFileReference).