storing and loading file
storeContents: aStringOrByteArray to: relativeFileName relativeTo: directoryFileReference
	"Store the contents to a file inside of a directory."
	<return: #FileReference>
	| fileReference path subDirectory |
	path := Path from: relativeFileName.
	fileReference := directoryFileReference withPath: path.
	subDirectory := directoryFileReference.
	path segments allButLastDo: [ :eachSegment | 
		subDirectory := subDirectory / eachSegment.
		subDirectory ensureCreateDirectory ].
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :aStream | aStream nextPutAll: aStringOrByteArray ].
	^ fileReference