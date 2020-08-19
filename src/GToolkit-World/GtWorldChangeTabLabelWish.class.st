Class {
	#name : #GtWorldChangeTabLabelWish,
	#superclass : #GtWorldChangeTabAppearanceWish,
	#instVars : [
		'label',
		'icon'
	],
	#category : #'GToolkit-World-Events'
}

{ #category : #'api - building' }
GtWorldChangeTabLabelWish >> applyOn: aBrTab [
	self label ifNotNil: [ :aLabel |
		aBrTab enqueueTask: (BlTaskAction new action: [ 
			aBrTab label: aLabel ])].
]

{ #category : #'api - accessing' }
GtWorldChangeTabLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtWorldChangeTabLabelWish >> label: anObject [
	label := anObject
]
