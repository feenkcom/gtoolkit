Class {
	#name : #GtHomeToolsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeToolsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'Tools').

	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self 
		newCardWithTitle: 'Playground' 
		description: 'Script, inspect and code. Live.'
		picture: ((GtPlayBook newDefault gtLiveFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card | self showSpaceWithTitle: 'Playground' with: GtPlaygroundStencil new create from: card ]).
	
	cardsContainer addChild: (self 
		newCardWithTitle: 'Coder'
		description: 'Browse, manipulate and organize code.'
		picture: (GtClassCoder forClass: GtClassCoder)
		action: [ :card | 	self showSpaceWithTitle: 'Coder' with: GtCoderStencil new create from: card ]).

	cardsContainer addChild: (self 
		newCardWithTitle: 'Spotter'
		description: 'Search anything. Really anything.'
		picture: GtSpotterSlide new create
		action: [ :card | card fireEvent: GtSpawnSpotter new ]).

	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
