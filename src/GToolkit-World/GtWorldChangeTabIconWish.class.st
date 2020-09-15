Class {
	#name : #GtWorldChangeTabIconWish,
	#superclass : #GtWorldChangeTabAppearanceWish,
	#instVars : [
		'icon'
	],
	#category : #'GToolkit-World-Events'
}

{ #category : #'api - building' }
GtWorldChangeTabIconWish >> applyOn: aBrTab [
	self icon ifNotNil: [ :anIcon |
		aBrTab enqueueTask: (BlTaskAction new action: [ 
			aBrTab icon: anIcon ])].
]

{ #category : #'api - accessing' }
GtWorldChangeTabIconWish >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtWorldChangeTabIconWish >> icon: anObject [
	icon := anObject
]
