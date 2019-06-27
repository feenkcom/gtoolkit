Class {
	#name : #GtSlide,
	#superclass : #BrStencil,
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtSlide >> name [
	^ (self class name gtRemovePrefix: 'Gt') gtRemoveSuffix: 'Slide'
]
