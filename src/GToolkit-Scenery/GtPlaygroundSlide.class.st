Class {
	#name : #GtPlaygroundSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtPlaygroundSlide >> create [
	| book |
	book := GtPlayBook newDefault.
	^ GtInspector createOnPlayBook: book
]
