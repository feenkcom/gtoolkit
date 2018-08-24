Extension { #name : #ZnEntity }

{ #category : #'*GToolkit-Utility-File' }
ZnEntity class >> gtPillar: aString [ 
	^ self stringEntityClass gtPillar: aString
]

{ #category : #'*GToolkit-Utility-File' }
ZnEntity class >> gtPng: bytes [
	^ self byteArrayEntityClass gtPng: bytes
]
