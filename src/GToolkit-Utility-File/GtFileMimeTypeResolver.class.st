Class {
	#name : #GtFileMimeTypeResolver,
	#superclass : #Object,
	#category : 'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileMimeTypeResolver class >> fromFileExtension: fileExtension [
	<return: #GtFileMimeTypeResolver or: nil>
	self allSubclassesDo: [ :eachClass | 
		(eachClass matchesFileExtension: fileExtension) ifTrue: [ 
			^ eachClass mimeTypeForFileExtention: fileExtension ] ].
	^ nil
]

{ #category : #testing }
GtFileMimeTypeResolver class >> matchesFileExtension: extensionString [ 
	"Return true if the extension matches a specific mime type"
	^ self supportedExtensions anySatisfy: [ :eachString | 
			eachString = extensionString ]
]

{ #category : #accessing }
GtFileMimeTypeResolver class >> mimeType [
	"Return a given ZnMimeType object that represents the given file extension"
	<return: #ZnMimeType>
	^ self subclassResponsibility
]

{ #category : #public }
GtFileMimeTypeResolver class >> mimeTypeForFileExtention: extensionString [
	"Return a given ZnMimeType object that represents the given file extension"
	<return: #ZnMimeType>
	^ self mimeType
]

{ #category : #accessing }
GtFileMimeTypeResolver class >> supportedExtensions [
	"Return collection of extensions that fits the specific mime type"
	<return: #Array of: #String>
	^ self subclassResponsibility
]
