Class {
	#name : #GtWorldChangeTabLabelWish,
	#superclass : #GtWorldChangeTabAppearanceWish,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-World-Events'
}

{ #category : #'api - building' }
GtWorldChangeTabLabelWish >> applyOn: aBrTab [
	self label ifNotNil: [ :aLabel |
		aBrTab enqueueTask: (BlTaskAction new action: [ 
			aBrTab label: aLabel.
			"When a tab is opened in a new window, the space title is used,
			we therefore update it too."
			(aBrTab model isKindOf: BlSpace) ifTrue: [ 
				aBrTab model title: aLabel asString ] ])].
]

{ #category : #'api - accessing' }
GtWorldChangeTabLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtWorldChangeTabLabelWish >> label: anObject [
	label := anObject
]
