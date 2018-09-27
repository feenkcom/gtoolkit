Extension { #name : #MemoryFileSystemFile }

{ #category : #'*GToolkit-Pharo6Compatibility' }
MemoryFileSystemFile >> binaryWriteStream [
	^ MemoryFileWriteStream on: self
]

{ #category : #'*GToolkit-Pharo6Compatibility' }
MemoryFileSystemFile >> close [
	 "do nothing"
]

{ #category : #'*GToolkit-Pharo6Compatibility' }
MemoryFileSystemFile >> size [

	^ size
]

{ #category : #'*GToolkit-Pharo6Compatibility' }
MemoryFileSystemFile >> updateContents: aCollection [
	bytes := aCollection.
	self updateSize: aCollection size
]
