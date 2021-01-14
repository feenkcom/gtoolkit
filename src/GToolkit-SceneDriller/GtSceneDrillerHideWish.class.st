Class {
	#name : #GtSceneDrillerHideWish,
	#superclass : #BlEvent,
	#category : #'GToolkit-SceneDriller-Events'
}

{ #category : #sending }
GtSceneDrillerHideWish >> sendTo: anObject [
	anObject hideDrillerEvent: self
]
