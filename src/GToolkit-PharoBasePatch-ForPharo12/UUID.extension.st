Extension { #name : #UUID }

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID >> base64Encoded [
	^ self 
		forPharo12AndNewer: [ self uuidData base64Encoded ] 
		forPharo11: [ super base64Encoded ]
]

{ #category : #'*GToolkit-PharoBasePatch-ForPharo12' }
UUID class >> fromBase64EncodedString: aString64 [
	| uid |
	uid := self nilUUID.
	self 
		forPharo12AndNewer: [
			(ZnBase64Encoder new 
				decode: aString64 readStream to: uid uuidData writeStream) ] 
		forPharo11: [
			ZnBase64Encoder new 
				decode: aString64 readStream to: uid writeStream ].
	^ uid
]
