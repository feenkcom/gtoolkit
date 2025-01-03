Extension { #name : #UUID }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID >> base64Encoded [
	^ self 
		forPharo12: [ self uuidData base64Encoded ] 
		forPharo11AndPharo10: [ super base64Encoded ]
]

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID class >> fromBase64EncodedString: aString64 [
	| uid |
	uid := self nilUUID.
	self 
		forPharo12: [
			uid uuidData: (ZnBase64Encoder new 
				decode: aString64 readStream to: uid uuidData writeStream) ] 
		forPharo11AndPharo10: [
			ZnBase64Encoder new 
				decode: aString64 readStream to: uid writeStream ].
	^ uid
]
