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
	cardsContainer addChild: self newPlaygroundButtonStencil create.
	cardsContainer addChild: self newCoderButtonStencil create.
	cardsContainer addChild: self newGitButtonStencil create.
	cardsContainer addChild: self newMonitorButtonStencil create.
	cardsContainer addChild: self newExamplesButtonStencil create.
	cardsContainer addChild: self newTranscriptButtonStencil create.
	cardsContainer addChild: self newMorphicWorldButtonStencil create.
	cardsContainer addChild: self newSpotterButtonStencil create.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newCoderButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Coder';
		icon: BrGlamorousIcons largeBook asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Coder'
				with: GtCoderStencil new create
				from: card ];
		description: 'Browse and manipulate code.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newExamplesButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Examples Explorer';
		icon: BrGlamorousIcons largeEg asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Examples Explorer'
				with:
					(GtInspector
						createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject)
				from: card ];
		description: 'Units of tests and of documentation. In one.'
]

{ #category : #accessing }
GtHomeToolsSection >> newGitButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Git';
		icon: BrGlamorousIcons largebranching asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Git'
				with:
					(GtInspector
						createOn: Gt4Git new allRepositoriesGroup)
				from: card ];
		description: 'Units of tests and of documentation. In one.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMonitorButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Monitor';
		icon: BrGlamorousIcons largeSignal asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Monitor'
				with: (GtInspector createOn: GtMonitoredBlocSpaces new)
				from: card ];
		description: 'Monitor processes and high level tasks.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMorphicWorldButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Morphic World';
		icon: BrGlamorousIcons largeWindow asElement;
		action: [ :card | card space host openMorphicWorld ];
		description: 'The legacy Morphic World interface and tools.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newPlaygroundButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Playground';
		icon: BrGlamorousIcons largePlay asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Playground'
				with: GtPlaygroundStencil new create
				from: card ];
		description: 'Play with code. Live.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newSpotterButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Spotter';
		icon: BrGlamorousIcons largeSearch asElement;
		action: [ :card | card fireEvent: GtSpawnSpotter new ];
		description: 'Search anything. Really anything.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newTranscriptButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Transcript';
		icon: BrGlamorousIcons largeTranscript asElement;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Transcript'
				with: GtTranscriptStencil new create
				from: card ];
		description: 'Transcript is the place to see logs.'
]
