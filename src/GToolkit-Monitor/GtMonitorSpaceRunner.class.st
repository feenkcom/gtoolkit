"
I start a space and let users know if everything went according to plan
"
Class {
	#name : #GtMonitorSpaceRunner,
	#superclass : #BrVerticalPane,
	#instVars : [
		'startButton',
		'stopButton',
		'logger',
		'toolbar',
		'signalTree',
		'resetButton'
	],
	#category : #'GToolkit-Monitor-Tools'
}

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> createLogger [
	| aLogger |

	aLogger := GtMonitorSpaceLogger new.

	^ aLogger
]

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> createSignalTree: aLogger [
	| signals view |

	signals := BlParallelUniverseSignal withAllSubclasses reject: #isAbstract.

	view := GtMondrian new.
	view nodes
		stencil: [ :aSignalClass | self createSignalTreeNode: aSignalClass logger: aLogger ];
		with: signals.
	view edges
		stencil: [ :a :from :to |
			| fromSignal toSignal edgeElement |
			
			fromSignal := from graph model.
			toSignal := to graph model.
			
			edgeElement := (fromSignal = toSignal
				or: [ fromSignal nextSignals size > 1 ])
				ifTrue: [
					BlParabollaArcElement new
						zIndex: 1;
						curvatureFraction: ((fromSignal nextSignals indexOf: toSignal) odd
							ifTrue: [ 1 ]
							ifFalse: [ -1 ]) ]
				ifFalse: [ BlLineElement new ].
				
			edgeElement border: (BlBorder paint: (Color lightGray alpha: 0.5) width: 2).
			edgeElement toHead:
				(BlArrowheadSimpleArrow new
					arrowLengthFraction: 8;
					arrowNoseAngle: 75;
					border: (BlBorder paint: (Color lightGray alpha: 0.5) width: 2)) ];
		fromCenterBottom;
		toCenterTop;
		connectToAll: #nextSignals.

	view layout tree nodeDistance: 15.
	^ (view root constraintsDo: [ :c | c horizontal matchParent ]) asPannableElement
]

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> createSignalTreeNode: aSignalClass logger: aLogger [ 
	| aNode theSignals |
	
	aNode := BrEditor new
		look: BrGlamorousRegularEditorLook new;
		fitContent;
		constraintsDo: [ :c | c maxWidth: 100 ];
		geometry: (BlRectangle cornerRadius: 5);
		padding: (BlInsets all: 5);
		border: (BlBorder paint: Color gray width: 1);
		background: (Color veryVeryLightGray);
		text: aSignalClass label.
	
	theSignals := OrderedCollection new.
	
	aLogger announcer when: aSignalClass do: [ :aSignal |
		theSignals add: aSignal.
		aNode background: BrGlamorousColors successBackgroundColor.
		aNode border: (BlBorder paint: BrGlamorousColors successBorderColor width: 1) ].
	
	aNode when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		
		theSignals isNotEmpty
			ifTrue: [
				theSignals size > 1
					ifTrue: [ anEvent currentTarget phlow spawnObject: theSignals ]
					ifFalse: [ anEvent currentTarget phlow spawnObject: theSignals anyOne ] ] ].

	^ aNode
]

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> createSpace [
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace extent: 100@75.
	aSpace title: 'Test Space'.
	aSpace addChild: (BrLabel new
		look: (BrGlamorousLabelLook new fontSize: 50);
		text: 'Test Space') asScalableElement.

	^ aSpace
]

{ #category : #initialization }
GtMonitorSpaceRunner >> initialize [
	super initialize.
	
	self matchParent.

	space := self createSpace.
	logger := self createLogger.
	
	toolbar := BrToolbar new
		look: BrGlamorousToolbarLook new.
	
	startButton := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Start';
		action: [ :aButton | self start ].

	stopButton := BrButton new
		disable;
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Stop';
		action: [ self stop ].
		
	resetButton := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Reset';
		action: [ self reset ].

	toolbar addItems: { startButton . stopButton . resetButton }.
	
	signalTree := self createSignalTree: logger.
	
	self addChild: toolbar.
	self addChild: signalTree
]

{ #category : #accessing }
GtMonitorSpaceRunner >> reset [
	self stop.
	
	logger := self createLogger.
	self replaceChild: signalTree with: (signalTree := self createSignalTree: logger)
]

{ #category : #accessing }
GtMonitorSpaceRunner >> start [
	space isOpened
		ifTrue: [ ^ self ].

	startButton disable.
	stopButton enable.

	logger start.
	self showSpace: space
]

{ #category : #accessing }
GtMonitorSpaceRunner >> stop [		
	startButton enable.
	stopButton disable.

	space close.
	logger stop; reset
]
