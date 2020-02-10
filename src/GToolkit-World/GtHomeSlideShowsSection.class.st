Class {
	#name : #GtHomeSlideShowsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtHomeSlideShowsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Slideshows').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'Tour' 
		slideshow: [ GtTour new create ]
		description: 'Take an interative tour through the tools and engines.').
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'One rendering tree' 
		slideshow: [ GtOneRenderingTree new create ]
		description: 'In Glamorous Toolkit, all rendering relies on a single tree at a time.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Pharo 101'
		slideshow: [ GtPharo101 new create ]
		description: 'New to Pharo? Take an introductory tutorial.').
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
