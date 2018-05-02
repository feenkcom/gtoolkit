accessing - file
fileReferenceOfFileName: relativeFileName relativeTo: directoryFileReference 
	<return: #FileReference>
	| path |
	path := Path from: relativeFileName.
	^ directoryFileReference resolvePath: path.