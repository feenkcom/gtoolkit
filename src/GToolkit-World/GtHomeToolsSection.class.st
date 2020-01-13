Class {
	#name : #GtHomeToolsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeToolsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Tools').

	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Playground'
		icon: BrGlamorousIcons largePlay asElement
		action: [ :card | self showSpaceWithTitle: 'Playground' with: GtPlaygroundStencil new create from: card ]
		description: 'Play with code. Live.').

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Coder'
		icon: BrGlamorousIcons largeBook asElement
		action: [ :card | 	self showSpaceWithTitle: 'Coder' with: GtCoderStencil new create from: card ]
		description: 'Browse and manipulate code.').

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Monitor'
		icon: BrGlamorousIcons largeSignal asElement
		action: [ :card | self 
			showSpaceWithTitle: 'Monitor' 
			with: (GtInspector createOn: GtMonitoredBlocSpaces new)
			from: card ]
		description: 'Monitor processes and high level tasks.').	

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Examples'
		icon: BrGlamorousIcons largeEg asElement
		action: [ :card | self 
			showSpaceWithTitle: 'Examples' 
			with: (GtInspector createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject)
			from: card ]
		description: 'Units of tests and of documentation. In one.').	

	cardsContainer addChild: (self 
		newToolCardWithTitle: 'Spotter'
		icon: BrGlamorousIcons largeSearch asElement
		action: [ :card | card fireEvent: GtSpawnSpotter new ]
		description: 'Search anything. Really anything.').


	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
