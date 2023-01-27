Class {
	#name : #GtHomeGetStartedSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeGetStartedSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Get started').
	cardsContainer := self newCardsContainer.

	cardsContainer
		addChild: (self
				newShowCardWithTitle: 'Tour'
				slideshow: [ GtPresenterSlideShow create: GtTour new ]
				description: 'Take an interactive tour through the environment.').

	cardsContainer
		addChild: (self
				newLepiterPageCardForPageNamed: 'Glamorous Toolkit'
				inDatabaseNamed: 'Glamorous Toolkit Book'
				withTitle: 'Glamorous Toolkit Book'
				andDescription: 'Read the Glamorous Toolkit book').

	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
