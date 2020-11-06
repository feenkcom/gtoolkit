Class {
	#name : #GtNotificationDebugSessionElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'textEditor',
		'toolbarElement',
		'borderElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - accessing' }
GtNotificationDebugSessionElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #'private - actions' }
GtNotificationDebugSessionElement >> debug [
	self debugSessionDo: [ :aSession | 
		aSession debug.
		self dismiss ]
]

{ #category : #'private - accessing' }
GtNotificationDebugSessionElement >> debugSessionDo: aBlock [
	self
		notificationDo: [ :anEvent | anEvent debugSession ifNotNil: aBlock ]
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterRight
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initialize [
	super initialize.
	self initializeBorderElement.
	self initializeTextEditor.
	self initializeToolbarElement.

	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer alignCenterRight.
		aContainer addChild: self textEditor as: #label.
		aContainer addChild: self toolbarElement as: #toolbar ].

	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor;
		anyToFitContent: self toolbarElement).
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
		borderDo: [ :anElement | 
			anElement border: (BlBorder paint: BrGlamorousColors errorBackgroundColor width: 1) ];
		withCloseButtonAction: [ self terminate ]
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeTextEditor [
	textEditor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection.
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeToolbarElement [
	| aDebugButton |
	toolbarElement := BrToolbar new
		look: BrGlamorousToolbarLook;
		fitContent.
		
	aDebugButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		beSmall;
		icon: BrGlamorousVectorIcons debug;
		label: 'Debug';
		action: [ self debug ].
		
	self toolbarElement 
		addItem: aDebugButton
]

{ #category : #'private - instance creation' }
GtNotificationDebugSessionElement >> newTextDescribingSession: aSession [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: aSession name asString.
		aSession interruptedContext 
			ifNotNil: [ :anInterruptedContext | 
				| aStack aShortStack |
				aStack := anInterruptedContext stack.
				aShortStack := aStack first: (3 min: aStack size).
				aShortStack do: [ :aContext | 
					aStream cr.
					aStream nextPutAll: aContext printString ] ] ]
]

{ #category : #'private - announcement handling' }
GtNotificationDebugSessionElement >> onDebugSessionDebugged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self dismiss ])
]

{ #category : #'private - announcement handling' }
GtNotificationDebugSessionElement >> onDebugSessionTerminated: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self dismiss ])
]

{ #category : #'private - hooks' }
GtNotificationDebugSessionElement >> onNotificationChanged [
	super onNotificationChanged.
	self updateElement.
]

{ #category : #'private - subscriptions' }
GtNotificationDebugSessionElement >> subscribeToNotification [
	super subscribeToNotification.
	self debugSessionDo: [ :aSession | 
		aSession 
			when: GtSharedDebugSessionDebuggedAnnouncement
			send: #onDebugSessionDebugged:
			to: self; 
			when: GtSharedDebugSessionTerminatedAnnouncement
			send: #onDebugSessionTerminated:
			to: self ]
]

{ #category : #'private - actions' }
GtNotificationDebugSessionElement >> terminate [
	self debugSessionDo: [ :aSession |
		aSession terminate.
		self dismiss.
	].
]

{ #category : #accessing }
GtNotificationDebugSessionElement >> textEditor [
	<return: #BrEditor>
	^ textEditor
]

{ #category : #'private - accessing' }
GtNotificationDebugSessionElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]

{ #category : #'private - subscriptions' }
GtNotificationDebugSessionElement >> unsubscribeFromNotification [
	super unsubscribeFromNotification.
	self debugSessionDo: [ :aSession |
		aSession unsubscribe: self ]
]

{ #category : #'private - updating' }
GtNotificationDebugSessionElement >> updateElement [
	self debugSessionDo: [ :aSession |
		| aText | 
		aText := self newTextDescribingSession: aSession.
		self textEditor text: aText ]
]
