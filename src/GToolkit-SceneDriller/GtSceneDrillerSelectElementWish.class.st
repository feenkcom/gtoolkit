Class {
	#name : #GtSceneDrillerSelectElementWish,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-SceneDriller-Events'
}

{ #category : #accessing }
GtSceneDrillerSelectElementWish >> element [
	^ element
]

{ #category : #accessing }
GtSceneDrillerSelectElementWish >> element: anObject [
	element := anObject
]

{ #category : #sending }
GtSceneDrillerSelectElementWish >> sendTo: anObject [
	anObject selectElementEvent: self
]
