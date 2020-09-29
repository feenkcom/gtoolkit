"
I exemplify ${class:GtWorldTabElement}$.
"
Class {
	#name : #GtWorldTabElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnSelectedTabCloseAction [
	<gtExample>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: true.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]

{ #category : #'examples - show space' }
GtWorldTabElementExamples >> showSpaceSelect_ReleaseSpaceOnUnselectedTabCloseAction [
	<gtExample>
	| aSpace aWorld aTabs |
	aSpace := BlSpace new.
	aWorld := GtWorldTabElement new.
	aWorld showSpace: aSpace select: false.
	aTabs := aWorld tabs.
	aTabs viewModel removeTab: (aTabs viewModel tabs at: 2).
	aSpace := aSpace asWeakReference.
	Smalltalk garbageCollect.
	self assert: (aSpace at: 1) equals: nil.
	^ aWorld
]
