Class {
	#name : #GtFilePlayBookTypeResolver,
	#superclass : #GtFileMimeTypeResolver,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFilePlayBookTypeResolver class >> mainExtension [
	^ 'playbook'
]

{ #category : #accessing }
GtFilePlayBookTypeResolver class >> mimeType [
	^ ZnMimeType applicationJson
]

{ #category : #accessing }
GtFilePlayBookTypeResolver class >> supportedExtensions [
	"Return collection of extensions that fits the specific mime type"
	<return: #Array of: #String>
	^ { self mainExtension }
]
