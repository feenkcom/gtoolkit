Class {
	#name : #GtHomeExternalLinksSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeExternalLinksSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'External links').
	
	cardsContainer := self newCardsContainer.
	
	cardsContainer addChild: (self 
		newCardWithTitle: 'Web' 
		description: 'The official webpage.'
		picture: (GtTitleSlide new
			titleText: ('gtoolkit.com' asRopedText glamorousRegularFont fontSize: 20))
		action: [ :card | WebBrowser openOn: 'https://gtoolkit.com' ]).	

	cardsContainer addChild: (self 
		newCardWithTitle: 'GitHub'
		description: 'Browse the code. Open issues. Engage.'
		picture: (GtTitleSlide new
			titleText: ('github.com/feenkcom/gtoolkit' asRopedText glamorousRegularFont fontSize: 20))
		action: [ :card | WebBrowser openOn: 'https://github.com/feenkcom/gtoolkit' ]).	
	
	cardsContainer addChild: (self 
		newCardWithTitle: 'Community' 
		description: 'Join our online community to ask questions and have fun.'
		picture: (GtTitleSlide new
			titleText: ('spectrum.chat/gtoolkit' asRopedText glamorousRegularFont fontSize: 25))
		action: [ :card | WebBrowser openOn: 'https://spectrum.chat/gtoolkit' ]).	
	
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
