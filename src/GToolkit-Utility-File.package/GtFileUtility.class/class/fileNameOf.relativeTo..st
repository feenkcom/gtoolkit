accessing - file
fileNameOf: aFileReference relativeTo: directoryFileReference
	<return: #String>	
	| path |
	path := self pathOf: aFileReference relativeTo: directoryFileReference.
	^ path delimiter join: path segments.