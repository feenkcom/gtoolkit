Class {
	#name : #GtWorld,
	#superclass : #BlElement,
	#classInstVars : [
		'world',
		'morphicWorld'
	],
	#category : #'GToolkit-World'
}

{ #category : #'system startup' }
GtWorld class >> cleanUp [
	<script: 'self cleanUp'>

	world ifNotNil: [
		world isOpened
			ifTrue: [ world close ].
		world := nil ].

	morphicWorld ifNotNil: [
		morphicWorld isOpened
			ifTrue: [ morphicWorld close ].
		morphicWorld := nil ]
]

{ #category : #'instance creation' }
GtWorld class >> create [
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Glamorous Toolkit'.
	aSpace addChild: self new.
	aSpace extent: 260@500.
	aSpace withSpotter.	
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> createMorphicWorld [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: 'Morph World'.
	aSpace extent: 1280@800.
	aSpace root: BlMorphicWorldEmbeddingElement new beMain.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>

	(world isNotNil and: [ world isOpened ])
		ifTrue: [ world close ].

	world := self create.

	world isOpened
		ifFalse: [ world show ]
]

{ #category : #'api - tools' }
GtWorld class >> openCoder [
	<script: 'self openCoder'>
	| aCoder aSpace |
		
	aCoder := GtInspector createOnPlayBook: (GtClassCoder new).

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Coder'.
	aSpace extent: 1200@600.
	aSpace addChild: aCoder.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openExamples [
	<script: 'self openExamples'>
	| anExamplesExplorer aSpace |
			
	anExamplesExplorer := GtInspector createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Examples'.
	aSpace extent: 1200@600.
	aSpace addChild: anExamplesExplorer.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openMonitor [
	<script: 'self openMonitor'>
	| aBlocSpacesMonitor aSpace |
			
	aBlocSpacesMonitor := GtInspector createOn: GtMonitoredBlocSpaces new.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Monitor'.
	aSpace extent: 1200@600.
	aSpace addChild: aBlocSpacesMonitor.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openMorphicWorld [
	<script: 'self openMorphicWorld'>

	morphicWorld
		ifNotNil: [ morphicWorld isOpened
			ifTrue: [ morphicWorld close ] ].

	morphicWorld
		ifNil: [ morphicWorld := self createMorphicWorld ].

	morphicWorld isOpened
		ifFalse: [ morphicWorld show ]
]

{ #category : #'api - tools' }
GtWorld class >> openPlayground [
	<script: 'self openPlayground'>
	| aPlayground aSpace |

	aPlayground := GtInspector createOnPlayBook: GtPlayBook newDefault.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Playground'.
	aSpace extent: 1200@600.
	aSpace addChild: aPlayground.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openSpotter [
	<script: 'self openSpotter'>
	| aSpotter aSpotterElement aSpace |
			
	aSpotter := GtSpotter new.
	aSpotterElement := GtSpotterElementWithPreview new.
	aSpotterElement spotterModel: aSpotter.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Spotter'.
	aSpace extent: 750@500.
	aSpace root: aSpotterElement.
	aSpace borderless: true.
	aSpace withHalos.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openTour [
	<script: 'self openTour'>
	| aTour aSpace |

	aTour := GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit).

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Glamorous Toolkit Tour'.
	aSpace extent: 1200@600.
	aSpace addChild: aTour.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld class >> openTranscript [
	<script: 'self openTranscript'>
	| aTranscriptElement aSpace |

	aTranscriptElement :=  GtTranscript default asElement.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Transcript'.
	aSpace extent: 400@600.
	aSpace addChild: aTranscriptElement.
	aSpace withHalos.
	aSpace withSpotter.
	aSpace show
]

{ #category : #spotter }
GtWorld class >> spotterShortcut [
	^ BlShortcut new
		repeatable: false;
		combination: BlKeyCombination shiftReturn;
		action: [ GtWorld openSpotter ]
]

{ #category : #config }
GtWorld class >> useBlocAwareDefaultPharoDebuggers [
	"Use the default debugger from Pharo but with support for handling the Bloc UI process.
	This makes sure the Bloc UI process is restarted automatically in case of exceptions in that process."
	BlBlocMorphicUIManager useAsDefault.
	GTGenericStackDebugger register.
	GtEmbeddedDebuggerElement register. "Allow the embeddable debugger as it will open the default debugger"
]

{ #category : #config }
GtWorld class >> useDefaultPharoDebuggers [
	"Use the default debugger from Pharo without support for handling the Bloc UI process.
	The Bloc UI process need to be restarted automatically after every exception that happens in that process."
	MorphicUIManager new beDefault.
	GTGenericStackDebugger register.
	GtEmbeddedDebuggerElement disable.
]

{ #category : #config }
GtWorld class >> useDualMorpicBlocDebuggers [
	"Confiugure a setup where the default Bloc based debugger is openened for errors in the Bloc UI process,
	and the Pharo default debugger for all other errors."
	GtDualDebuggerUIManager useAsDefault.
	GtEmbeddedDebuggerElement register.
	GTGenericStackDebugger register.
]

{ #category : #config }
GtWorld class >> useGToolkitDebuggersAsDefault [
	"Set the gtoolkit debugger as default for all errors.
	This includes errors that happen in the Morphic UI process."
	GtBlocMorphicUIManager useAsDefault.
	GtEmbeddedDebuggerElement register.
	GtExpandableDebuggerElement register.
]

{ #category : #initialization }
GtWorld >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self padding: (BlInsets top: 10 bottom: 10).
	self initializeElements
]

{ #category : #initialization }
GtWorld >> initializeElements [

	self removeChildren.
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Tour';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openTour ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Playground';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openPlayground ]).
			
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Coder';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openCoder ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Spotter';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openSpotter ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Transcript';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openTranscript ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Examples';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openExamples ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Monitor';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openMonitor ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Morphic World';
		hMatchParent;
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self class openMorphicWorld ]).
		
	self addChild: (BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		margin: (BlInsets top: 5 left: 10 bottom: 5 right: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {
			BrButton new
				look: BrGlamorousButtonWithLabelLook new;
				label: 'Save';
				hMatchParent;
				action: [ Smalltalk snapshot: true andQuit: false ].
				
			BrButton new
				look: (BrGlamorousButtonWithLabelLook new);
				label: 'Quit';
				hMatchParent;
				action: [ Smalltalk snapshot: false andQuit: true ] }).

	self addChild: (BrSimpleList new
		display: (GtSceneryBuilder build items);
		margin: (BlInsets top: 20 left: 0 bottom: 5 right: 0);
		stencil: [ :item |
			BrButton new
				look: BrGlamorousButtonWithLabelLook new;
				label: item name;
				hMatchParent;
				margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
				action: [ item action value ] ]).
]

{ #category : #'hooks - children' }
GtWorld >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self initializeElements
]
