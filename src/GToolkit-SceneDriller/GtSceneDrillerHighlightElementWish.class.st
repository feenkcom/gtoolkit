Class {
	#name : #GtSceneDrillerHighlightElementWish,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-SceneDriller-Events'
}

{ #category : #accessing }
GtSceneDrillerHighlightElementWish >> element [
	^ element
]

{ #category : #accessing }
GtSceneDrillerHighlightElementWish >> element: anObject [
	element := anObject
]

{ #category : #sending }
GtSceneDrillerHighlightElementWish >> sendTo: anObject [
	anObject highlightElementEvent: self
]
