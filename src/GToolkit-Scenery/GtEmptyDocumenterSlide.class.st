Class {
	#name : #GtEmptyDocumenterSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtEmptyDocumenterSlide >> create [
	^ GtInspector createOnPlayBook: (GtDocument new)
]
