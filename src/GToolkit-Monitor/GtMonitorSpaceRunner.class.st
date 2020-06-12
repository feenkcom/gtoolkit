"
!Welcome to the space runner!

Here you will learn what happens when ask to ==show== a ${class:BlSpace}$. On the right is a flow diagram of the important actions that should happen in order for a space to appear. By default all nodes in the diagram are gray, meaning that those actions didn't happen yet.

Now press the ==Start== button to show a new space created by ${method:GtMonitorSpaceRunner>>#createSpace}$. Don't be afraid, expand the method to customize and create your own space!

If everything worked correctly a new space should have appeared and most of the step in the diagram are now green. It is possible that a few nodes are still gray, it means that those steps were not neccessary and were skipped. Important is that there is a path in the flow diagram that goes from the very first step until the end and connects only green nodes.

Congratulations! Your Space is alive! Feel free to play with it :)
When done press the ==Stop== button to safely close the space. Or press the ==Reset== button to put everything back, just like it was before.
"
Class {
	#name : #GtMonitorSpaceRunner,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'startButton',
		'stopButton',
		'logger',
		'toolbar',
		'signalTree',
		'resetButton',
		'monitoredSpace'
	],
	#category : #'GToolkit-Monitor-Space Runner'
}

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> createExplanation [
	^ (GtDocument new text: self explanationText) asElementWithoutSaveAction
			matchParent;
			constraintsDo: [ :c | c linear weight: 0.75 ];
			margin: (BlInsets left: 10)
]

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
	| aContainer aNode theSignals |
	
	aContainer := BrHorizontalPane new fitContent.
	
	aNode := BrEditor new
		look: BrGlamorousRegularEditorLook new;
		fitContent;
		constraintsDo: [ :c | c maxWidth: 100 ];
		geometry: (BlRectangle cornerRadius: 5);
		padding: (BlInsets all: 5);
		border: (BlBorder paint: Color gray width: 1);
		background: (Color veryVeryLightGray);
		text: aSignalClass label;
		preventMeAndChildrenMouseEvents.

	theSignals := OrderedCollection new.
	
	aLogger announcer when: aSignalClass do: [ :aSignal |
		theSignals add: aSignal.
		aNode background: BrGlamorousColors successBackgroundColor.
		aNode border: (BlBorder paint: BrGlamorousColors successBorderColor width: 1) ].
	
	aContainer when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		
		theSignals isNotEmpty
			ifTrue: [
				theSignals size > 1
					ifTrue: [ anEvent currentTarget phlow spawnObject: theSignals ]
					ifFalse: [ anEvent currentTarget phlow spawnObject: theSignals anyOne ] ] ].
			
	aContainer addChild: aNode.

	^ aContainer
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

{ #category : #'instance creation' }
GtMonitorSpaceRunner >> explanationText [
	^ self class comment
]

{ #category : #initialization }
GtMonitorSpaceRunner >> initialize [
	super initialize.
	
	self matchParent.

	monitoredSpace := self createSpace.
	logger := self createLogger.
	
	toolbar := BrToolbar new
		look: BrGlamorousToolbarLook new.
	
	startButton := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		beSmall;
		label: 'Start';
		action: [ :aButton | self start ].

	stopButton := BrButton new
		disable;
		beSmall;
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Stop';
		action: [ self stop ].
		
	resetButton := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		beSmall;
		label: 'Reset';
		action: [ self reset ].

	toolbar addItems: { startButton . stopButton . resetButton }.
	
	signalTree := self createSignalTree: logger.
	
	self addChild: self createExplanation.
	self addChild: (BrVerticalPane new
		alignCenter;
		margin: (BlInsets all: 10);
		matchParent;
		addChildren: { toolbar . signalTree })
]

{ #category : #accessing }
GtMonitorSpaceRunner >> reset [
	self stop.
	
	logger := self createLogger.
	signalTree parent replaceChild: signalTree with: (signalTree := self createSignalTree: logger)
]

{ #category : #accessing }
GtMonitorSpaceRunner >> start [
	monitoredSpace isOpened
		ifTrue: [ ^ self ].

	startButton disable.
	stopButton enable.

	logger start.
	monitoredSpace show
]

{ #category : #accessing }
GtMonitorSpaceRunner >> stop [		
	startButton enable.
	stopButton disable.

	monitoredSpace close.
	logger stop; reset
]
