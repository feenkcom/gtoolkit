Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Pharo6Compatibility' }
AbstractFileReference >> binaryWriteStream [
	"Answer a binary write stream on the receiver"

	^ self subclassResponsibility
]

{ #category : #'*GToolkit-Pharo6Compatibility' }
AbstractFileReference >> binaryWriteStreamDo: aBlock [
	"Pass a binary write stream on the receiver to the supplied block, and ensure that the stream is closed after evaluation."

	| stream |

	stream := self binaryWriteStream.
	^ [ aBlock value: stream ] 
		ensure: [ stream close ]
]
