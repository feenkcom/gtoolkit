Class {
	#name : #GtFilePlayBookTypeResolver,
	#superclass : #GtFileMimeTypeResolver,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFilePlayBookTypeResolver class >> mimeType [
	^ ZnMimeType textPlain
		sub: 'gtoolkit-playbook';
		yourself
]

{ #category : #accessing }
GtFilePlayBookTypeResolver class >> supportedExtensions [
	"Return collection of extensions that fits the specific mime type"
	<return: #Array of: #String>
	^ #( 'playbook' )
]
