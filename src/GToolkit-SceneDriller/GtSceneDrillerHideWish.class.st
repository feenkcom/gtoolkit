Class {
	#name : #GtSceneDrillerHideWish,
	#superclass : #BlEvent,
	#category : #'GToolkit-SceneDriller'
}

{ #category : #sending }
GtSceneDrillerHideWish >> sendTo: anObject [
	anObject hideHalo: self
]
