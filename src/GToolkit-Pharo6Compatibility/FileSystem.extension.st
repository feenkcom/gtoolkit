Extension { #name : #FileSystem }

{ #category : #'*GToolkit-Pharo6Compatibility' }
FileSystem >> binaryWriteStreamOn: aResolvable [
	"Resolve the argument into an absolute path and open a file handle on the file
	at that path. Ask the handle to give us a binary write stream for reading the file."

	^ (self open: aResolvable writable: true) binaryWriteStream.
]
