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
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'Tour' 
		slideshow: [ GtLiveShow createWithArrowsVisible: GtTour new ]
		description: 'Take an interative tour through the tools and engines.').
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'Moldable Development' 
		slideshow: [ GtLiveShow createWithArrowsVisible: GtMoldableDevelopmentSlideshow new ]
		description: 'A tour through the moldable development concepts.').
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
