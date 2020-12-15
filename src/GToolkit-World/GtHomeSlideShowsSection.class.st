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
		slideshow: [ GtLiveShow createWithArrowsVisible: GtTour new ]
		description: 'Take an interative tour through the tools and engines.').
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'Tour' 
		slideshow: [ GtLiveShow createWithArrowsVisible: GtMoldableDevelopmentSlideshow new ]
		description: 'A tour through the moldable development concepts.').
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'One rendering tree' 
		slideshow: [ GtLiveShow createWithArrowsVisible: GtOneRenderingTree new ]
		description: 'In Glamorous Toolkit, all rendering relies on a single tree at a time.').
	cardsContainer addChild: (self 
		newShowCardWithTitle: 'Inspector views' 
		slideshow: [ GtLiveShow createWithArrowsVisible: GtInspectorViews new ]
		description: 'Every object can define how it can be viewed in the inspector. Learn how this work.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Pharo 101'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtPharo101 new ]
		description: 'New to Pharo? Take an introductory tutorial.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Querying Code'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtQueries new ]
		description: 'Search is pervasive in Glamorous Toolkit. Learn more about queries and how to use them.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Working With a REST API'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtWorkingWithARestApi new ]
		description: 'GT is a client side technology. Learn how to create exploratory tools for a remote API.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Spotter'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtSpotterSlideshow new ]
		description: 'Spotter is the moldable search interface. Learn more about it.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Playground and Inspector'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtPlaygroundAndInspectorSlideshow new ]
		description: 'Playground and Inspector are the core tools that enable live exploration. Learn more about them.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Coder'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtCoderSlideshow new ]
		description: 'Coder offers the means through which we manipulate static code.').
	cardsContainer addChild: (self
		newShowCardWithTitle: 'Moldable Analysis'
		slideshow: [ GtLiveShow createWithArrowsVisible: GtMoldableAnalysisPresentation new ]
		description: 'Moldable Analysis.').
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
