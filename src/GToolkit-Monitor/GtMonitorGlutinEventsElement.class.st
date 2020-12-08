Class {
	#name : #GtMonitorGlutinEventsElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGlutinEventVisitor',
	#classTraits : 'TGlutinEventVisitor classTrait',
	#instVars : [
		'startButton',
		'stopButton',
		'resetButton',
		'eventsList',
		'logger',
		'isPaused',
		'disabledEvents',
		'eventTypes',
		'eventTypesList'
	],
	#category : #'GToolkit-Monitor-Glutin Events Logger'
}

{ #category : #initialization }
GtMonitorGlutinEventsElement >> allGlutinEventTypes [
	^ GlutinWindowEvent allSubclasses, GlutinDeviceEvent allSubclasses, GlutinCommonEvent allSubclasses 
]

{ #category : #initialization }
GtMonitorGlutinEventsElement >> defaultEventTypes [
	| theEventTypes |

	theEventTypes := OrderedDictionary new.
	self allGlutinEventTypes do: [ :eachEventType |
		theEventTypes at: eachEventType put: true ].
	
	GlutinCommonEvent allSubclasses do: [ :eachEventType |
		theEventTypes at: eachEventType put: false ].
	
	theEventTypes at: GlutinMouseWheelEvent put: false.
	theEventTypes at: GlutinCursorMovedEvent put: false.
	
	^ theEventTypes
]

{ #category : #initialization }
GtMonitorGlutinEventsElement >> disableEventType: aClass [
	eventTypes at: aClass put: false.
	logger interestingEvents: self enabledGlutinEventTypes.
	eventTypesList items: eventTypes associations.
]

{ #category : #initialization }
GtMonitorGlutinEventsElement >> enableEventType: aClass [
	eventTypes at: aClass put: true.
	logger interestingEvents: self enabledGlutinEventTypes.
	eventTypesList items: eventTypes associations.
]

{ #category : #initialization }
GtMonitorGlutinEventsElement >> enabledGlutinEventTypes [
	^ eventTypes associations
		select: [ :each | each value ]
		thenCollect: [ :each | each key ]
]

{ #category : #initialization }
GtMonitorGlutinEventsElement >> initialize [
	super initialize.
	
	self matchParent.
	self cellSpacing: 10.
	self padding: (BlInsets top: 10 bottom: 10).
	
	eventTypes := self defaultEventTypes.
	
	logger := GtMonitorGlutinEventsLogger new.
	logger interestingEvents: self enabledGlutinEventTypes.
	isPaused := false.
	
	startButton := BrButton new
		disable;
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: 'Start';
		action: [ :aButton | self start ].

	stopButton := BrButton new
		disable;
		beSmallSize;
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Stop';
		action: [ self stop ].
		
	resetButton := BrButton new
		disable;
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: 'Reset';
		action: [ self reset ].
	
	eventTypesList := BrSimpleList new
		matchParent;
		items: eventTypes associations;
		stencil: [ :anAssociation |
			BrHorizontalPane new
				hMatchParent;
				vFitContent;
				alignCenterLeft;
				cellSpacing: 10;
				addChildren: {
					BrCheckbox new
						look: BrGlamorousCheckboxLook;
						checked: anAssociation value;
						whenCheckedDo: [ self enableEventType: anAssociation key ];
						whenUncheckedDo: [ self disableEventType: anAssociation key ].
 
					BrLabel new
						look: (BrGlamorousLabelLook new foreground: (
							anAssociation value
								ifTrue: [ Color black ]
								ifFalse: [ Color gray ]
						));
						text: anAssociation key class name.
				} ].
	
	self addChild: (BrVerticalPane new
		matchParent;
		cellSpacing: 5;
		addChild: (BrLabel new
			margin: (BlInsets left: 10);
			look: (BrGlamorousLabelLook new foreground: Color gray);
			text: 'Pick event types to log:'
		);
		addChild: eventTypesList).
	
	eventsList := BrColumnedList new
		addEventHandler: (GtPhlowListToSelectHandler new transformation: [ :aNode | aNode event ]);
		matchParent.
	eventsList column
		title: 'Timestamp';
		width: 100;
		stencil: [ :aGlutinEventSignal |
			BrLabel new
				look: (BrGlamorousLabelLook new glamorousRegularSmallSize foreground: Color gray);
				text: (String streamContents: [ :aStream | aGlutinEventSignal timestamp asTime print24: true showSeconds: true on: aStream ])].
	eventsList column
		title: 'Event';
		stencil: [ :aGlutinEventSignal |
			| anEventElement |
			
			anEventElement := aGlutinEventSignal event accept: self.
			anEventElement == self
				ifTrue: [
					BrLabel new
						look: BrGlamorousLabelLook new;
						text: aGlutinEventSignal event printString ]
				ifFalse: [ anEventElement ] ].
	
	self addChild: (BrVerticalPane new
		matchParent;
		cellSpacing: 10;
		addChildren: { 
			BrHorizontalPane new
				hMatchParent;
				vFitContent;
				alignTopCenter;
				cellSpacing: 5;
				addChildren: {
					startButton . stopButton . resetButton
				}.
			
			eventsList
		}).

	
	logger announcer when: Announcement send: #updateList to: self.
	
	self stop
]

{ #category : #private }
GtMonitorGlutinEventsElement >> newButtonElement: aText [
	^ BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		look: (BrShadowLook new width: 1; offset: 0@0.5);
		background: Color white;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		margin: (BlInsets all: 3);
		padding: (BlInsets all: 4);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: (BrLabel new
			look: (BrGlamorousLabelLook new glamorousCodeFont glamorousCodeTinySize tightMeasurement foreground: Color darkGray);
			text: aText)
]

{ #category : #private }
GtMonitorGlutinEventsElement >> newSquareButtonElement: aText [
	^ BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		look: (BrShadowLook new width: 1; offset: 0@0.5);
		background: Color white;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		margin: (BlInsets all: 3);
		padding: (BlInsets all: 4);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: (BrLabel new
			look: (BrGlamorousLabelLook new glamorousCodeFont tightMeasurement foreground: Color darkGray);
			text: aText)
]

{ #category : #'hooks - children' }
GtMonitorGlutinEventsElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	isPaused
		ifFalse: [ ^ self ].
	
	self start
]

{ #category : #'hooks - children' }
GtMonitorGlutinEventsElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	isPaused := logger isRunning.
	
	self stop
]

{ #category : #'api - logger' }
GtMonitorGlutinEventsElement >> reset [
	self resetLogger
]

{ #category : #private }
GtMonitorGlutinEventsElement >> resetLogger [
	logger reset
]

{ #category : #'api - logger' }
GtMonitorGlutinEventsElement >> start [
	self
		startLogger.
		
	stopButton enable.
	startButton disable.
	resetButton disable
]

{ #category : #private }
GtMonitorGlutinEventsElement >> startLogger [
	logger start
]

{ #category : #'api - logger' }
GtMonitorGlutinEventsElement >> stop [
	self
		stopLogger.

	stopButton disable.
	startButton enable.
	resetButton enable
]

{ #category : #private }
GtMonitorGlutinEventsElement >> stopLogger [
	logger stop
]

{ #category : #private }
GtMonitorGlutinEventsElement >> updateList [
	eventsList items: logger recordings
]

{ #category : #'event - visiting' }
GtMonitorGlutinEventsElement >> visitCharacterReceivedEvent: anEvent [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: { 
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: 'Character recevied'.
			BlElement new
				width: 2;
				height: 0.
			
			self newSquareButtonElement: anEvent text }
]

{ #category : #'event - visiting' }
GtMonitorGlutinEventsElement >> visitKeyboardInputEvent: anEvent [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: { 
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: ('Key {1}' format: {
					anEvent state = GlutinEventInputElementState Pressed
						ifTrue: [ 'pressed' ]
						ifFalse: [ 'released' ] }).
			BlElement new
				width: 2;
				height: 0.

			anEvent state = GlutinEventInputElementState Pressed
				ifTrue: [ BrGlamorousVectorIcons downwards asElement ]
				ifFalse: [ BrGlamorousVectorIcons upwards asElement ].
			
			self newButtonElement: (anEvent has_virtual_keycode
				ifTrue: [ anEvent virtual_keycode item asString ]
				ifFalse: [ anEvent scan_code asString ]). }
]

{ #category : #'event - visiting' }
GtMonitorGlutinEventsElement >> visitModifiersChanged: anEvent [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: ({ 
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: 'Modifiers changed'.
			
			anEvent shift
				ifTrue: [ self newButtonElement: 'shift' ].
				
			anEvent ctrl
				ifTrue: [ self newButtonElement: 'ctrl' ].
				
			anEvent alt
				ifTrue: [ self newButtonElement: 'alt' ].
				
			anEvent logo
				ifTrue: [ self newButtonElement: 'logo' ].
			
		} select: #notNil).
]

{ #category : #'event - visiting' }
GtMonitorGlutinEventsElement >> visitMouseInputEvent: anEvent [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		addChildren: { 
			BrLabel new
				look: BrGlamorousLabelLook new;
				text: ('Mouse {1}' format: {
					anEvent state = GlutinEventInputElementState Pressed
						ifTrue: [ 'pressed' ]
						ifFalse: [ 'released' ] }).
			BlElement new
				width: 2;
				height: 0.

			anEvent state = GlutinEventInputElementState Pressed
				ifTrue: [ BrGlamorousVectorIcons downwards asElement ]
				ifFalse: [ BrGlamorousVectorIcons upwards asElement ].
			
			self newButtonElement: (anEvent button button_type = GlutinEventMouseButtonType Other
				ifTrue: [ anEvent button button_code asString ]
				ifFalse: [ anEvent button button_type item asString ]). }
]
