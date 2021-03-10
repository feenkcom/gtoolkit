"
I initialize ${class:GtPager}$ when opened using ${method:GtWorldUtility class>>#showSpaceWithTitle:inPager:with:from:}$.
"
Class {
	#name : #GtWorldPagerConfiguration,
	#superclass : #Object,
	#instVars : [
		'contentElementActions'
	],
	#category : #'GToolkit-World-Utilities'
}

{ #category : #'api - applying' }
GtWorldPagerConfiguration >> applyOn: aPager [
	self 
		contentElementDo: [ :aContentElement | 
			contentElementActions do: [ :aValuable | 
				aValuable value: aContentElement ] ] 
		in: aPager
]

{ #category : #'api - scripting' }
GtWorldPagerConfiguration >> beNormalLevel [
	self contentElementAction: [ :anElement | anElement beNormalLevel ]
]

{ #category : #'api - scripting' }
GtWorldPagerConfiguration >> contentElementAction: aValuable [
	contentElementActions := contentElementActions copyWith: aValuable
]

{ #category : #'private - applying' }
GtWorldPagerConfiguration >> contentElementDo: aBlock in: aPager [
	| aContentElement |
	aPager pages ifEmpty: [ ^ self ].
	aContentElement :=  aPager pages last contentElement..
	aBlock value: aContentElement
]

{ #category : #initialization }
GtWorldPagerConfiguration >> initialize [
	super initialize.
	contentElementActions := Array empty.
]
