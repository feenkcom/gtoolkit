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
		newHeaderCardWithTitle: 'Glamorour Toolkit'
		description: 'Read the Glamorour Toolkit book'
		size: 200@150
		content:
			(BrLabel new
				text: 'Glamorous Toolkit Book';
				aptitude: BrGlamorousLabelAptitude new
					bold;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			| database startPage |
			database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase 
				databaseNamed: 'feenkcom/gtoolkit/lepiter'.
			startPage := database pageNamed: 'Glamorous Toolkit'.
			GtWorldUtility 
				showSpaceWithTitle: startPage title
				inPagerWith: [ startPage
					asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil
				from: card ]).
			
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
