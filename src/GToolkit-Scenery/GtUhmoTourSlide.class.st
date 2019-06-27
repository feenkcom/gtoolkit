Class {
	#name : #GtUhmoTourSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtUhmoTourSlide >> create [
	^ GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfUhmo)
]
