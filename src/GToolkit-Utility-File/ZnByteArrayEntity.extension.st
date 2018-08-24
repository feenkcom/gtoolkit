Extension { #name : #ZnByteArrayEntity }

{ #category : #'*GToolkit-Utility-File' }
ZnByteArrayEntity class >> gtPng: byteArray [
	^ (self type: ZnMimeType imagePng length: byteArray size)
		bytes: byteArray;
		yourself 
]
