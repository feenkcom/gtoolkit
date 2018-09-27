Extension { #name : #FileHandle }

{ #category : #'*GToolkit-Pharo6Compatibility' }
FileHandle >> binaryWriteStream [
	^ (File named: reference fullName) writeStream
]
