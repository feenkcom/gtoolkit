Class {
	#name : #GtNotificationDebugSessionElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'textEditor',
		'toolbarElement',
		'borderElement',
		'stackListElement'
	],
	#category : #'GToolkit-Notifications-DebugSession'
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
	self initializeStackList.
	self initializeToolbarElement.

	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer alignCenterRight.
		aContainer addChild: self textEditor as: #label.
		aContainer addChild: self stackListElement as: #stack.
		aContainer addChild: self toolbarElement as: #toolbar ].

	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor;
		hInherit: self stackListElement;
		anyToFitContent: self toolbarElement).
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
		borderDo: [ :anElement | 
			anElement 
				border: (BlBorder paint: BrGlamorousColors errorBackgroundColor width: 1);
				padding: (BlInsets all: 0) ];
		withCloseButtonAction: [ self terminate ]
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeStackList [
	stackListElement := BrSimpleList new
		hMatchParent;
		vExact: 50;
		padding: (BlInsets top: 5 right: 9 bottom: 10 left: 9);
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | DebugSession ];
		itemStencil: [ :anEventElementClass :aListWidget | 
			BrLabel new
				look: (BrGlamorousLabelLook new
					glamorousRegularFont;
					glamorousRegularSmallSize);
				hMatchParent;
				vFitContent ];
		itemDataBinder: [ :aLabel :aContext :anItemIndex | 
				aLabel text: (self textForContext: aContext) ]
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeTextEditor [
	textEditor := BrEditor new
		look: (BrGlamorousRegularEditorLook new
			glamorousRegularFont;
			glamorousRegularSmallSize);
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10);
		background: BrGlamorousColors errorBackgroundColor;
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection.
]

{ #category : #initialization }
GtNotificationDebugSessionElement >> initializeToolbarElement [
	| aDebugButton |
	toolbarElement := BrToolbar new
		look: BrGlamorousToolbarLook;
		padding: (BlInsets top: 5 right: 10 bottom: 10 left: 10);
		fitContent.
		
	aDebugButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		beSmallSize;
		icon: BrGlamorousVectorIcons debug;
		label: 'Debug';
		action: [ self debug ].
		
	self toolbarElement 
		addItem: aDebugButton
]

{ #category : #'private - instance creation' }
GtNotificationDebugSessionElement >> newTextDescribingSession: aSession [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: aSession name asString ]
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

{ #category : #'private - accessing' }
GtNotificationDebugSessionElement >> stackListElement [
	<return: #BrSimpleList>
	^ stackListElement
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

{ #category : #'private - instance creation' }
GtNotificationDebugSessionElement >> textForContext: aContext [
	^ aContext printString
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
		self updateTextEditor.
		self updateStackList. ]
]

{ #category : #'private - updating' }
GtNotificationDebugSessionElement >> updateStackList [
	self debugSessionDo: [ :aSession |
		aSession interruptedContext 
			ifNotNil: [ :anInterruptedContext | 
				anInterruptedContext stack ifNotNil: [ :aStack |
					self stackListElement items: aStack ] ] ]
]

{ #category : #'private - updating' }
GtNotificationDebugSessionElement >> updateTextEditor [
	self debugSessionDo: [ :aSession |
		| aText | 
		aText := self newTextDescribingSession: aSession.
		self textEditor text: aText ]
]
