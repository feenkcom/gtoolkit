Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Docs').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkit).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitInspector).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitPlayground).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitCoder).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitSpotter).
	cardsContainer addChild: (self newDocCardForClass: GtMoldableDevelopmentExplanation).
	cardsContainer addChild: (self newDocCardForClass: GtWhatMakesBlocSpecialExplanation).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
