Class {
	#name : #GtFilePillarMimeTypeResolver,
	#superclass : #GtFileMimeTypeResolver,
	#category : 'GToolkit-Utility-File'
}

{ #category : #public }
GtFilePillarMimeTypeResolver class >> mimeType [
	"Return a given ZnMimeType object that represents the given file extension"
	<return: #ZnMimeType>
	^ ZnMimeType textPlain
		sub: 'pillar';
		yourself
]

{ #category : #accessing }
GtFilePillarMimeTypeResolver class >> supportedExtensions [
	"Return collection of extensions that fits the specific mime type"
	<return: #Array of: #String>
	^ #( 'pillar' )
]
