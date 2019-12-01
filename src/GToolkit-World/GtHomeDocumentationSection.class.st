Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'Documentation').
	
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self 
		newCardWithTitle: 'Documentation' 
		description: 'Start from the central point and inspect your way through the docs.'
		picture: (((GtDocument new text: (BaselineOfGToolkit comment first: 500)) gtTextFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit)) from: card ]).
	
	cardsContainer addChild: (self 
		newCardWithTitle: 'Examples'
		description: 'Examples are both tests and units of documentation.'
		picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOn: (GtRlGToolkitExamplesExplorer buildForGToolkitProject)) from: card ]).
		
	cardsContainer addChild: (self 
		newCardWithTitle: 'Tour'
		description: 'Take an interative tour through the tools and engines.'
		picture: (GtTitleSlide new
			titleText: ('glamoroustoolkit' asRopedText 
				fontSize: 30; fontName: 'Helvetica Neue'; bold;
				in: [:title | (title from: 1 to: 'glamorous' size) thin];
				yourself))
		action: [ :card |self showSpaceWithTitle: 'Tour' with: (GtTour new create makeArrowsVisible) from: card ]).

	cardsContainer addChild: (self 
		newCardWithTitle:'One rendering tree' 
		description: 'All rendering relies on a single tree at a time.'
		picture: (GtTitleSlide new
			titleText: ('One rendering tree' asRopedText glamorousRegularFont
				fontSize: 30))
		action: [ :card | self showSpaceWithTitle: 'One rendering tree' with: (GtOneRenderingTree new create makeArrowsVisible) from: card ]).

	cardsContainer addChild: (self 
		newCardWithTitle:'Pharo 101' 
		description: 'New to Pharo? Take an introductory tutorial.'
		picture: (GtTitleSlide new
			titleText: ('Pharo 101' asRopedText glamorousRegularFont
				fontSize: 30))
		action: [ :card | self showSpaceWithTitle: 'Pharo 101' with: (GtPharo101 new create makeArrowsVisible) from: card ]).
	
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
