Class {
	#name : #GtWorldChangeTabAppearanceChangeHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabReference'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #visiting }
GtWorldChangeTabAppearanceChangeHandler >> changeTitleWish: aWish [
	self updateTitleIconFromWish: aWish.
	self updateTitleLabelFromWish: aWish.
]

{ #category : #'api - accessing' }
GtWorldChangeTabAppearanceChangeHandler >> eventsToHandle [
	^ { GtPhlowChangeTitleWish }
]

{ #category : #'api - event managing' }
GtWorldChangeTabAppearanceChangeHandler >> handleEvent: aGtWorldChangeTabAppearanceWish [
	aGtWorldChangeTabAppearanceWish sendTo: self.
	aGtWorldChangeTabAppearanceWish consumed: true.
]

{ #category : #accessing }
GtWorldChangeTabAppearanceChangeHandler >> tab [
	^ tabReference ifNotNil: [ :aWeakReference | aWeakReference at: 1 ]
]

{ #category : #accessing }
GtWorldChangeTabAppearanceChangeHandler >> tab: aBrTab [
	tabReference := aBrTab asWeakReference
]

{ #category : #enumerating }
GtWorldChangeTabAppearanceChangeHandler >> tabDo: aBlock [
	self tab ifNotNil: aBlock
]

{ #category : #'private - updating' }
GtWorldChangeTabAppearanceChangeHandler >> updateTitleIconFromWish: aWish [
	self tabDo: [ :aBrTab |
		aWish iconDo: [ :anIcon |
			aBrTab enqueueTask: (BlTaskAction new action: [ 
				aBrTab icon: anIcon ])]].
]

{ #category : #'private - updating' }
GtWorldChangeTabAppearanceChangeHandler >> updateTitleLabelFromWish: aWish [
	self tabDo: [ :aBrTab |
		aWish labelDo: [ :aLabel |
			aBrTab enqueueTask: (BlTaskAction new action: [ 
				aBrTab label: aLabel.
				"When a tab is opened in a new window, the space title is used,
				we therefore update it too."
				(aBrTab model isKindOf: BlSpace) ifTrue: [ 
					aBrTab model title: aLabel asString ] ])]].
]
