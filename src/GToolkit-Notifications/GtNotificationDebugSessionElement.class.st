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
		self switchToSystemDebugger.
		self dismiss.
	]
]

{ #category : #'private - accessing' }
GtNotificationDebugSessionElement >> debugSessionDo: aBlock [
	self eventDo: [ :anEvent | 
		anEvent debugSession ifNotNil: aBlock ]
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

{ #category : #'private - hooks' }
GtNotificationDebugSessionElement >> onEventChanged [
	super onEventChanged.
	self updateElement.
]

{ #category : #'private - actions' }
GtNotificationDebugSessionElement >> switchToSystemDebugger [
	self debugSessionDo: [ :aSession |
		Smalltalk tools debugger 
			openOn: aSession 
			withFullView: true 
			andNotification: nil. ]
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

{ #category : #'private - updating' }
GtNotificationDebugSessionElement >> updateElement [
	self debugSessionDo: [ :aSession |
		self textEditor text: aSession name ]
]
