Extension { #name : #ZnPositionableReadStream }

{ #category : #'*GToolkit-Pharo6Compatibility' }
ZnPositionableReadStream >> binary [
	stream binary
]

{ #category : #'*GToolkit-Pharo6Compatibility' }
ZnPositionableReadStream >> reset [
	self position: 0
]
