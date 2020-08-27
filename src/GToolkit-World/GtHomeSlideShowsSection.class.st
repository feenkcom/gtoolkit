Class {
	#name : #GtHomeSlideShowsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
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
		newShowCardWithTitle: 'Inspector views' 
		slideshow: [ GtInspectorViews new create ]
		description: 'Every object can define how it can be viewed in the inspector. Learn how this work.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Pharo 101'
		slideshow: [ GtPharo101 new create ]
		description: 'New to Pharo? Take an introductory tutorial.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Querying Code'
		slideshow: [ GtQueries new create ]
		description: 'Search is pervasive in Glamorous Toolkit. Learn more about queries and how to use them.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Working With a REST API'
		slideshow: [GtWorkingWithARestApi new create ]
		description: 'GT is a client side technology. Learn how to create exploratory tools for a remote API.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Spotter'
		slideshow: [GtSpotterSlideshow new create ]
		description: 'Spotter is the moldable search interface. Learn more about it.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Playground and Inspector'
		slideshow: [GtPlaygroundAndInspectorSlideshow new create ]
		description: 'Playground and Inspector are the core tools that enable live exploration. Learn more about them.').
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
