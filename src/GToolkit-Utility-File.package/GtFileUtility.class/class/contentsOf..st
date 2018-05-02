storing and loading file
contentsOf: aFileReference
	"This should be replaced with ZnStreamingEntity usage"
	| mime |
	mime := self mimeTypeOfFileReference: aFileReference.
	^ mime isBinary
		ifTrue: [ | bytes |
			bytes := aFileReference binaryReadStreamDo: [ :aStream | 
				aStream contents ] ] 
		ifFalse: [ aFileReference contents ]