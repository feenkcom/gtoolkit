"
Fire the ""scene driller show wish"" from withing the graphical scene whose root has ${class:GtSceneDrillerEventHandler}$ event handler to transform the scene into debug mode
"
Class {
	#name : #GtSceneDrillerShowWish,
	#superclass : #BlEvent,
	#category : #'GToolkit-SceneDriller'
}

{ #category : #sending }
GtSceneDrillerShowWish >> sendTo: anObject [
	anObject showHalo: self
]
