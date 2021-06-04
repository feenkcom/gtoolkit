"
Fire the ""scene driller show wish"" from withing the graphical scene whose root has ${class:GtSceneDrillerEventHandler}$ event handler to transform the scene into debug mode
"
Class {
	#name : #GtSceneDrillerShowWish,
	#superclass : #BlEvent,
	#instVars : [
		'elementToSelect',
		'sceneExtent'
	],
	#category : #'GToolkit-SceneDriller-Events'
}

{ #category : #accessing }
GtSceneDrillerShowWish >> elementToSelect [
	^ elementToSelect
]

{ #category : #accessing }
GtSceneDrillerShowWish >> elementToSelect: anObject [
	elementToSelect := anObject
]

{ #category : #accessing }
GtSceneDrillerShowWish >> sceneExtent [
	^ sceneExtent
]

{ #category : #accessing }
GtSceneDrillerShowWish >> sceneExtent: anObject [
	sceneExtent := anObject
]

{ #category : #sending }
GtSceneDrillerShowWish >> sendTo: anObject [
	anObject showDrillerEvent: self
]
