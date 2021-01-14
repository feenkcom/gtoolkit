Class {
	#name : #GtSceneDrillerHideHighlightWish,
	#superclass : #BlEvent,
	#category : #'GToolkit-SceneDriller-Events'
}

{ #category : #sending }
GtSceneDrillerHideHighlightWish >> sendTo: anObject [
	anObject hideHighlightEvent: self
]
