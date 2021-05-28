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
		aptitude: (BrShadowAptitude new beLarge);
		padding: (BlInsets top: 10 left: 0 bottom: 10 right: 0).
	cardsContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 0).
	cardsContainer addChild: self newPlaygroundButtonStencil create.
	
	GtImage isLepiterEnabled ifTrue: [ 
		cardsContainer addChild: self newNotesButtonStencil create.
		cardsContainer addChild: self newLepiterButtonStencil create ].
		
	cardsContainer addChild: self newCoderButtonStencil create as: GtHomeCoderButtonId.
	cardsContainer addChild: self newGitButtonStencil create.
	cardsContainer addChild: self newMonitorButtonStencil create.
	cardsContainer addChild: self newExamplesButtonStencil create.
	cardsContainer addChild: self newTranscriptButtonStencil create.
	cardsContainer addChild: self newFileSystemButtonStencil create.
	cardsContainer addChild: self newMorphicWorldButtonStencil create.
	cardsContainer addChild: self newSpotterButtonStencil create.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'tools creation' }
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

{ #category : #'tools creation' }
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

{ #category : #'tools creation' }
GtHomeToolsSection >> newFileSystemButtonStencil [
	^ GtToolButtonStencil new 
		title: 'File system';
		icon: BrGlamorousVectorIcons folder;
		action: [ :card | 
			(GtPhlowCompositeTool new
				addTool: (GtFileBrowserFolderTool forFolder: '.');
				addTool: (GtInspectorTool forObject: '.' asFileReference))
					asElementDo: [ :anElement |
						self
							showSpaceWithIcon: BrGlamorousVectorIcons folder
							title: 'File system'
							with: (GtPager createWrappedOn: anElement) maximized
							from: card ] ];
		description: 'Browse the file system.'
]

{ #category : #'tools creation' }
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

{ #category : #'tools creation' }
GtHomeToolsSection >> newLepiterButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Lepiter';
		icon: LeIcons lepiterDatabase;
		action: [ :card | 
			self
				showSpaceWithIcon: LeIcons lepiterDatabase
				title: 'Lepiter'
				with: LeLepiterToolStencil new
				from: card ];
		description: 'Lepiter'
]

{ #category : #'tools creation' }
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

{ #category : #'tools creation' }
GtHomeToolsSection >> newMorphicWorldButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Morphic World';
		icon: BrGlamorousVectorIcons largeWindow;
		action: [ :card | card space host openMorphicWorld ];
		description: 'The legacy Morphic World interface and tools.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newNotesButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Note';
		icon: LeIcons lepiterPage;
		action: [ :card | 
			self
				showSpaceWithIcon: LeIcons lepiterPage
				title: 'Note'
				with: LeNotePlaygroundStencil new
				from: card ];
		description: 'Take notes. Live.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newPlaygroundButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Playground';
		icon: (GtPlaygroundStencil playgroundClass defaultIcon);
		action: [ :card | 
			self
				showSpaceWithIcon: GtPlaygroundStencil playgroundClass defaultIcon
				title: 'Playground'
				with: GtPlaygroundStencil new
				from: card ];
		description: 'Play with code. Live.'
]

{ #category : #'tools creation' }
GtHomeToolsSection >> newSpotterButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Spotter';
		icon: BrGlamorousVectorIcons largeSearch;
		action: [ :card | card fireEvent: GtSpawnSpotter new ];
		description: 'Search anything. Really anything.'
]

{ #category : #'tools creation' }
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
