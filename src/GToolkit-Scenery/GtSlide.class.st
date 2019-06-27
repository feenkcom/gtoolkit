Class {
	#name : #GtSlide,
	#superclass : #BrStencil,
	#instVars : [
		'cachedElement'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtSlide >> asCachedElement [
	^ cachedElement ifNil: [ cachedElement := self asElement ]
]

{ #category : #accessing }
GtSlide >> name [
	^ (self class name gtRemovePrefix: 'Gt') gtRemoveSuffix: 'Slide'
]
