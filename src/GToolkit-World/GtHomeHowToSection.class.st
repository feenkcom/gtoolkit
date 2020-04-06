Class {
	#name : #GtHomeHowToSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtHomeHowToSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'How to').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self newDocCardForClass: GtWorkWithGitHubIcebergMetacelloHowToGuide).
	cardsContainer addChild: (self newDocCardForClass: GtWorkWithQueriesHowToGuide).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
