GT-Examples-UI
gtDisplayValidityOn: aStream
	self isValid ifTrue: [ ^ self ].
	
	aStream nextPutAll: ' [invalid]'