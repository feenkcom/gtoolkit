Class {
	#name : #GtHomeExternalLinksSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
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
				newUrlCardWithTitle: 'feenkcom/gtoolkit on GitHub'
				description: 'Browse the code. Open issues. Engage.'
				url: 'https://github.com/feenkcom/gtoolkit').
	cardsContainer
		addChild:
			(self
				newUrlCardWithTitle: 'spectrum.chat/gtoolkit'
				description: 'Join our online community.'
				url: 'https://spectrum.chat/gtoolkit').
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
