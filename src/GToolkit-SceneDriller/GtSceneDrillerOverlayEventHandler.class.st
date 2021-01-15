Class {
	#name : #GtSceneDrillerOverlayEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'overlay'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #'element handlers' }
GtSceneDrillerOverlayEventHandler >> elementAddedToSceneGraphEvent: anEvent [
	self overlay showElement: anEvent currentTarget.
	self overlay updatePositions
]

{ #category : #'element handlers' }
GtSceneDrillerOverlayEventHandler >> elementExtentChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : #'element handlers' }
GtSceneDrillerOverlayEventHandler >> elementPositionInSpaceChangedEvent: anEvent [
	self overlay updatePositions
]

{ #category : #'element handlers' }
GtSceneDrillerOverlayEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self overlay hideElement: anEvent currentTarget
]

{ #category : #'api - accessing' }
GtSceneDrillerOverlayEventHandler >> eventsToHandle [
	^ {
		BlElementPositionInSpaceChangedEvent.
		BlElementExtentChangedEvent.
		BlElementRemovedFromSceneGraphEvent.
		BlElementAddedToSceneGraphEvent.
	}
]

{ #category : #accessing }
GtSceneDrillerOverlayEventHandler >> overlay [
	^ overlay
]

{ #category : #accessing }
GtSceneDrillerOverlayEventHandler >> overlay: anObject [
	overlay := anObject
]
