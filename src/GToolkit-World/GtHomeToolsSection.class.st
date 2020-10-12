Class {
	#name : #GtHomeToolsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'api - instantiation' }
GtHomeToolsSection >> create [
	| sectionContainer cardsContainer items |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Tools').
	cardsContainer := self newCardsContainer.
	items := self collectItemStencils collect: [ :e | e create ].
	cardsContainer addChildren: items.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newCoderButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Coder';
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Coder'
				with: GtCoderStencil new create
				from: card ];
		description: 'Browse and manipulate code.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newExamplesButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Examples Explorer';
		icon: BrGlamorousVectorIcons largeEg;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Examples Explorer'
				with:
					(GtInspector
						createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject) maximized
				from: card ];
		description: 'Units of tests and of documentation. In one.'
]

{ #category : #accessing }
GtHomeToolsSection >> newGitButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Git';
		icon: BrGlamorousVectorIcons largebranching;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Git'
				with:
					(GtInspector
						createOn: Gt4Git new allRepositoriesGroup) maximized
				from: card ];
		description: 'Manage git repositories.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMonitorButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Monitor';
		icon: BrGlamorousVectorIcons largeSignal;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Monitor'
				with: (GtInspector createOn: GtMonitor new) maximized
				from: card ];
		description: 'Monitor processes and high level tasks.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMorphicWorldButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Morphic World';
		icon: BrGlamorousVectorIcons largeWindow;
		action: [ :card | card space host openMorphicWorld ];
		description: 'The legacy Morphic World interface and tools.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newPlaygroundButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Playground';
		icon: BrGlamorousVectorIcons largePlay;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Playground'
				with: GtPlaygroundStencil new create
				from: card ];
		description: 'Play with code. Live.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newSpotterButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Spotter';
		icon: BrGlamorousVectorIcons largeSearch;
		action: [ :card | card fireEvent: GtSpawnSpotter new ];
		description: 'Search anything. Really anything.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newTranscriptButtonStencil [
	<gtSectionItem>
	^ GtToolButtonStencil new 
		title: 'Transcript';
		icon: BrGlamorousVectorIcons largeTranscript;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Transcript'
				with: GtTranscriptStencil new create
				from: card ];
		description: 'Transcript is the place to see logs.'
]
