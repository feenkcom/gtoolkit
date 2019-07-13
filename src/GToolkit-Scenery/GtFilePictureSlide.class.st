Class {
	#name : #GtFilePictureSlide,
	#superclass : #GtSlide,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtFilePictureSlide >> create [
	| form |
	form := PNGReadWriter formFromFileNamed: self fileReference fullName.
	^ (BlElement new 
			size: form extent;
			background: (BlImageBackground new image: form)) asPannableElement
]

{ #category : #accessing }
GtFilePictureSlide >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtFilePictureSlide >> fileReference: aStringOrFileReference [
	fileReference := aStringOrFileReference asFileReference 
]
