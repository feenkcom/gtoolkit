Class {
	#name : #GtNotificationDebugSessionElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'textEditor',
		'toolbarElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

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
	self initializeTextEditor.
	self initializeToolbarElement.
	
	self addChild: self textEditor as: #label.
	self addChild: self toolbarElement as: #toolbar.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor;
		anyToFitContent: self toolbarElement).
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
	| aDebugButton aTerminateButton |
	toolbarElement := BrToolbar new
		look: BrGlamorousToolbarLook;
		fitContent.
		
	aDebugButton := BrButton new
		look: BrGlamorousButtonWithLabelLook;
		beSmall;
		label: 'Debug';
		action: [ self debug ].
		
	aTerminateButton := BrButton new
		look: BrGlamorousButtonWithLabelLook;
		beSmall;
		label: 'Terminate';
		action: [ self terminate ].
		
	self toolbarElement 
		addItem: aDebugButton;
		addItem: aTerminateButton
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
		self textEditor text: aSession name ]
]
