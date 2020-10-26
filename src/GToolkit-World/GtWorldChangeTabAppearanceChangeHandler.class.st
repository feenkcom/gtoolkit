Class {
	#name : #GtWorldChangeTabAppearanceChangeHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabReference'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'api - accessing' }
GtWorldChangeTabAppearanceChangeHandler >> eventsToHandle [
	^ { GtWorldChangeTabAppearanceWish }
]

{ #category : #'api - event managing' }
GtWorldChangeTabAppearanceChangeHandler >> handleEvent: aGtWorldChangeTabAppearanceWish [
	self tab ifNotNil: [ :aTab | aGtWorldChangeTabAppearanceWish applyOn: aTab ]
]

{ #category : #accessing }
GtWorldChangeTabAppearanceChangeHandler >> tab [
	^ tabReference ifNotNil: [ :aWeakReference | aWeakReference at: 1 ]
]

{ #category : #accessing }
GtWorldChangeTabAppearanceChangeHandler >> tab: aBrTab [
	tabReference := aBrTab asWeakReference
]
