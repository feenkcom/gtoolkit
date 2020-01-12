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
		newToolCardWithTitle: 'Playground'
		icon: BrGlamorousIcons largePlay asElement
		action: [ :card | self showSpaceWithTitle: 'Playground' with: GtPlaygroundStencil new create from: card ]).

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Coder'
		icon: BrGlamorousIcons largeBook asElement
		action: [ :card | 	self showSpaceWithTitle: 'Coder' with: GtCoderStencil new create from: card ]).

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Spotter'
"		description: 'Search anything. Really anything.'"
		icon: BrGlamorousIcons largeSearch asElement
		action: [ :card | card fireEvent: GtSpawnSpotter new ]).

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Examples'
		icon: BrGlamorousIcons largeEg asElement
		action: [ :card | self 
			showSpaceWithTitle: 'Examples' 
			with: (GtInspector createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject)
			from: card ]).	

	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newToolCardWithTitle: aString icon: anElement action: aBlock [
	| iconElement labelElement |
	iconElement := anElement margin: (BlInsets bottom: 5).
	labelElement := BrLabel new 
	    text: aString;
	    look: (BrGlamorousLabelLook new fontSize: 14).
	^ BrButton new
		constraintsDo:[ :c | 
	        c horizontal exact: 120.
	        c vertical exact: 120 ];
		margin: (BlInsets all: 20);
		action: aBlock;
		padding: (BlInsets all: 10);
		look: BrGlamorousButtonExteriorLook new;
		geometry: (BlRectangle cornerRadius: 4);
		layout: BlLinearLayout vertical alignCenter;
		addChild: iconElement;
		addChild: labelElement.
]
