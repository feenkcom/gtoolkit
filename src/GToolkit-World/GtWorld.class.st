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
	aSpace extent: 200@500.
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

	world
		ifNil: [ world := self create ].

	world isOpened
		ifFalse: [ world show ]
]

{ #category : #'instance creation' }
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
	| aPlayground aSpace |

	aPlayground := GtInspector createOnPlayBook: GtPlayBook newDefault.
	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Playground'.
	aSpace extent: 1200@600.
	aSpace addChild: aPlayground.
	aSpace withSpotter.
	aSpace withHalos.
	aSpace show
]

{ #category : #spotter }
GtWorld class >> openSpotter [
	| aSpotter aSpotterElement aSpace |
			
	aSpotter := GtSpotter new.
	aSpotterElement := GtSpotterElementWithPreview new.
	aSpotterElement spotterModel: aSpotter.
	aSpotterElement searchField requestFocus.

	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Spotter'.
	aSpace extent: 800@600.
	aSpace root: aSpotterElement.
	aSpace borderless: true.
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
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openTour ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Playground';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openPlayground ]).
			
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Coder';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openCoder ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Spotter';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openSpotter ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Transcript';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openTranscript ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Examples';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openExamples ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Monitor';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openMonitor ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Morphic World';
		constraintsDo: [ :c | c horizontal matchParent  ];
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
		action: [ self openMorphicWorld ]).

	self addChild: (BrSimpleList new
		display: (GtSceneryBuilder build items);
		margin: (BlInsets top: 20 left: 0 bottom: 5 right: 0);
		stencil: [ :item |
			BrButton new
				look: BrGlamorousButtonWithLabelLook new;
				label: item name;
				constraintsDo: [ :c | c horizontal matchParent  ];
				margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20);
				action: [ item action value ] ]).
]

{ #category : #initialization }
GtWorld >> initializeLogo [
	| aText |
	
	aText := 'gt' asRopedText fontSize: 30.
	(aText from: 1 to: 1) thin.
	(aText from: 2 to: aText size) bold.
	
	self addChild: (BlTextElement new
		padding: (BlInsets top: 20 bottom: 20);
		text: aText;
		constraintsDo: [ :c | c linear horizontal alignCenter ]).
]

{ #category : #'hooks - children' }
GtWorld >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self initializeElements
]

{ #category : #'api - tools' }
GtWorld >> openCoder [
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
GtWorld >> openExamples [
	| anExamplesExplorer aSpace |
			
	anExamplesExplorer := GtInspector createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Examples'.
	aSpace extent: 1200@600.
	aSpace addChild: anExamplesExplorer.
	aSpace show
]

{ #category : #accessing }
GtWorld >> openMonitor [
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Monitor'.
	aSpace addChild: (GtInspector createOn: GtMonitoredBlocSpaces new)..
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld >> openMorphicWorld [
	self class openMorphicWorld
]

{ #category : #'api - tools' }
GtWorld >> openPlayground [
	self class openPlayground
]

{ #category : #'api - tools' }
GtWorld >> openSpotter [
	self class openSpotter
]

{ #category : #'api - tools' }
GtWorld >> openTour [
	| aTour aSpace |

	aTour := GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit).

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Glamorous Toolkit Tour'.
	aSpace extent: 1200@600.
	aSpace addChild: aTour.
	aSpace withSpotter.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld >> openTranscript [ 
	| aTranscriptElement aSpace |

	aTranscriptElement :=  GtTranscript default asElement.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost default.
	aSpace title: 'Transcript'.
	aSpace extent: 400@600.
	aSpace addChild: aTranscriptElement.
	aSpace withSpotter.
	aSpace show
]
