Class {
	#name : #GtWorldUtility,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-World-Utilities'
}

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithIcon: anIcon title: aString with: aStencil from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace icon: anIcon.
	aSpace extent: 1200@600.
	aSpace root background: Color transparent.
	aSpace addChild: aStencil asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPager: aPagerConfiguration with: aStencil from: anotherElement [
	| anElement aPager |
	anElement := aStencil asElement.
	aPager := GtPager createWrappedOn: anElement.
	aPager maximized.
	aPagerConfiguration applyOn: aPager.
	^ self showSpaceWithTitle: aString with: aPager from: anotherElement.
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString inPagerWith: aStencil from: anotherElement [
	^ self 
		showSpaceWithTitle: aString 
		inPager: GtWorldPagerConfiguration new
		with: aStencil 
		from: anotherElement
]

{ #category : #'instance creation' }
GtWorldUtility class >> showSpaceWithTitle: aString with: aStencil from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace root background: Color transparent.
	aSpace addChild: aStencil asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace.
	^ aSpace
]
