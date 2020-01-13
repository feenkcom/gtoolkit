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
		newCardWithTitle: 'gtoolkit.com' 
		description: 'The official webpage.'
		action: [ :card | WebBrowser openOn: 'https://gtoolkit.com' ]).	

	cardsContainer addChild: (self 
		newCardWithTitle: 'github.com/feenkcom/gtoolkit' 
		description: 'Browse the code. Open issues. Engage.'
		action: [ :card | WebBrowser openOn: 'https://github.com/feenkcom/gtoolkit' ]).	

	cardsContainer addChild: (self 
		newCardWithTitle: 'spectrum.chat/gtoolkit' 
		description: 'Join our online community to ask questions and have fun.'
		action: [ :card | WebBrowser openOn: 'https://spectrum.chat/gtoolkit' ]).	

	cardsContainer addChild: (self 
		newCardWithTitle: 'feenk.com' 
		description: 'Our team.'
		action: [ :card | WebBrowser openOn: 'https://feenk.com' ]).	

	
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
