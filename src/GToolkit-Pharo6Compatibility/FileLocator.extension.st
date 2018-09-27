Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Pharo6Compatibility' }
FileLocator >> binaryWriteStream [
	"Answer a binary write stream on the receiver"

	^ self resolve binaryWriteStream
]
