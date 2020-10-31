Class {
	#name : #GtNotificationMessageElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'message',
		'textEditor',
		'dismissButton'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - asserting' }
GtNotificationMessageElement >> assertMessage: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Notification message must be non-nil' ].
]

{ #category : #initialization }
GtNotificationMessageElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterRight
]

{ #category : #defaults }
GtNotificationMessageElement >> defaultMessage [
	^ 'empty message'
]

{ #category : #'private - accessing' }
GtNotificationMessageElement >> dismissButton [
	<return: #BrButton>
	^ dismissButton
]

{ #category : #initialization }
GtNotificationMessageElement >> initialize [
	super initialize.
	message := self defaultMessage.
	self initializeTextEditor.
	self initializeDismissButton.
	
	self addChild: self textEditor as: #textEditor.
	self addChild: self dismissButton as: #dismissButton.
	
	self
		padding: (BlInsets all: 5);
		margin: (BlInsets all: 5).
	
	self addLook: BrGlamorousButtonExteriorLook. 
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor;
		anyToFitContent: self dismissButton).
]

{ #category : #initialization }
GtNotificationMessageElement >> initializeDismissButton [
	dismissButton := BrButton new
		look: BrGlamorousButtonWithLabelLook;
		beSmall;
		label: 'Dismiss';
		action: [ self dismiss ]
]

{ #category : #initialization }
GtNotificationMessageElement >> initializeTextEditor [
	textEditor := BrEditor new
		look: BrGlamorousRegularEditorLook;
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection;
		text: self message.
]

{ #category : #'api - accessing' }
GtNotificationMessageElement >> message [
	<return: #String>
	^ message
]

{ #category : #'api - accessing' }
GtNotificationMessageElement >> message: aString [
	self assertMessage: aString.
	message = aString ifTrue: [ ^ self ].
	message := aString.
	self onMessageChanged.
]

{ #category : #'private - hooks' }
GtNotificationMessageElement >> onEventChanged [
	super onEventChanged.
	self message: self event message.
]

{ #category : #'private - hooks' }
GtNotificationMessageElement >> onMessageChanged [
	self updateTextEditor.
]

{ #category : #'private - accessing' }
GtNotificationMessageElement >> textEditor [
	<return: #BrEditor>
	^ textEditor
]

{ #category : #'private - updating' }
GtNotificationMessageElement >> updateTextEditor [
	self textEditor text: self message.
]
