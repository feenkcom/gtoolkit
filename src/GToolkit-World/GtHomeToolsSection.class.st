Class {
	#name : #GtHomeToolsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'api - instantiation' }
GtHomeToolsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: Color white; 
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		look: (BrShadowLook new beLarge);
		padding: (BlInsets top: 10 left: 0 bottom: 10 right: 0).
	cardsContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 0).
	cardsContainer addChild: self newPlaygroundButtonStencil create.
	cardsContainer addChild: self newCoderButtonStencil create as: GtHomeCoderButtonId.
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
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedBrowse
				title: 'Coder'
				with: GtCoderStencil new
				from: card ];
		description: 'Browse and manipulate code.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newExamplesButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Exemplifier';
		icon: BrGlamorousVectorIcons largeEg;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Exemplifier'
				with:
					(GtInspector
						createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject) maximized
				from: card ];
		description: 'Units of tests and of documentation. In one.'
]

{ #category : #accessing }
GtHomeToolsSection >> newGitButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Git';
		icon: BrGlamorousVectorIcons largebranching;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Git'
				with:
					(GtInspector
						createOn: Gt4Git new) maximized
				from: card ];
		description: 'Manage git repositories.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMonitorButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Monitor';
		icon: BrGlamorousVectorIcons largeSignal;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Monitor'
				with: (GtInspector createOn: GtMonitor new) maximized
				from: card ];
		description: 'Monitor processes and high level tasks.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newMorphicWorldButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Morphic World';
		icon: BrGlamorousVectorIcons largeWindow;
		action: [ :card | card space host openMorphicWorld ];
		description: 'The legacy Morphic World interface and tools.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newPlaygroundButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Playground';
		icon: BrGlamorousVectorIcons largePlay;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedPlay
				title: 'Playground'
				with: GtPlaygroundStencil new
				from: card ];
		description: 'Play with code. Live.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newSpotterButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Spotter';
		icon: BrGlamorousVectorIcons largeSearch;
		action: [ :card | card fireEvent: GtSpawnSpotter new ];
		description: 'Search anything. Really anything.'
]

{ #category : #'api - instantiation' }
GtHomeToolsSection >> newTranscriptButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Transcript';
		icon: BrGlamorousVectorIcons largeTranscript;
		action: [ :card | 
			self
				showSpaceWithIcon: BrGlamorousVectorIcons emphasizedInspect
				title: 'Transcript'
				with: GtTranscriptStencil new
				from: card ];
		description: 'Transcript is the place to see logs.'
]
