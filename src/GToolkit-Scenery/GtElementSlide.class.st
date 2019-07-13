Class {
	#name : #GtElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtElementSlide >> create [
	^ element
]

{ #category : #accessing }
GtElementSlide >> element: anObject [
	element := anObject
]
