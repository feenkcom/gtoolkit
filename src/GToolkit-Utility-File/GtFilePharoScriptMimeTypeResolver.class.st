Class {
	#name : #GtFilePharoScriptMimeTypeResolver,
	#superclass : #GtFileMimeTypeResolver,
	#category : 'GToolkit-Utility-File'
}

{ #category : #public }
GtFilePharoScriptMimeTypeResolver class >> mimeType [
	^ ZnMimeType textPlain
		sub: 'pharo-script';
		yourself
]

{ #category : #accessing }
GtFilePharoScriptMimeTypeResolver class >> supportedExtensions [
	"Return collection of extensions that fits the specific mime type"
	<return: #Array of: #String>
	^ #( 'ph' )
]
