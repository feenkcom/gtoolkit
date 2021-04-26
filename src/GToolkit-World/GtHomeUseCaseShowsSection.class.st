Class {
	#name : #GtHomeUseCaseShowsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeUseCaseShowsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Use cases').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Working With a REST API'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtWorkingWithTheGitHubRestApiShow new ]
		description: 'Learn how to create exploratory tools for a remote API.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Analyzing Java systems'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtAnalyzingJavaSystemsShow new ]
		description: 'Analyzing Java systems').
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
