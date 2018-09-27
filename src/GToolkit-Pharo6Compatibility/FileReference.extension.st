Extension { #name : #FileReference }

{ #category : #'*GToolkit-Pharo6Compatibility' }
FileReference >> binaryWriteStream [
	"Answer a binary write stream on the receiver"

	^ ZnBufferedReadWriteStream on: (filesystem binaryWriteStreamOn: self path)
]
