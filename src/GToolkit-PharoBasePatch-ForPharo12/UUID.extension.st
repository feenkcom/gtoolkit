Extension { #name : #UUID }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID >> base64Encoded [
	^ self uuidData base64Encoded 
]

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID class >> fromBase64EncodedString: aString64 [
	| uid |
	uid := self nilUUID.
	(ZnBase64Encoder new 
			decode: aString64 readStream to: uid uuidData writeStream).
	^ uid
]
