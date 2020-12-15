Class {
	#name : #GtHomeExternalLinksSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'api - instantiation' }
GtHomeExternalLinksSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'External links').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self
				newUrlCardWithTitle: 'gtoolkit.com'
				description: 'The official webpage.'
				url: 'https://gtoolkit.com').
	cardsContainer
		addChild:
			(self
				newUrlCardWithTitle: 'feenk.com'
				description: 'Our team.'
				url: 'https://feenk.com').
	cardsContainer
		addChild:
			(self
				newUrlCardWithTitle: '@feenkcom on Twitter'
				description: 'Talk to us on Twitter.'
				url: 'https://twitter.com/feenkcom').

	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
