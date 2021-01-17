Class {
	#name : #GtHomeHowToSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeHowToSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'How to').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self newDocCardForClass: GtWorkWithGitHubIcebergMetacelloHowToGuide).
	cardsContainer addChild: (self newDocCardForClass: GtWorkWithQueriesHowToGuide).
	cardsContainer addChild: (self newDocCardForClass: GtCreateStandaloneAppHowToGuide).
	cardsContainer addChild: (self newDocCardForClass: GtScaleUIHowToGuide).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
