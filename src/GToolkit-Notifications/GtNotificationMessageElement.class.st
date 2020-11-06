Class {
	#name : #GtNotificationMessageElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'message',
		'textEditor',
		'borderElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - asserting' }
GtNotificationMessageElement >> assertMessage: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Notification message must be non-nil' ].
]

{ #category : #'private - accessing' }
GtNotificationMessageElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #initialization }
GtNotificationMessageElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterRight
]

{ #category : #defaults }
GtNotificationMessageElement >> defaultMessage [
	^ 'empty message'
]

{ #category : #initialization }
GtNotificationMessageElement >> initialize [
	super initialize.
	message := self defaultMessage.
	self initializeBorderElement.
	self initializeTextEditor.
	
	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer addChild: self textEditor as: #textEditor ].
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self borderElement;
		vAnyToFitContent: self borderElement;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor).
]

{ #category : #initialization }
GtNotificationMessageElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
		withCloseButtonAction: [ self dismiss ]
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
GtNotificationMessageElement >> onMessageChanged [
	self updateTextEditor.
]

{ #category : #'private - hooks' }
GtNotificationMessageElement >> onNotificationChanged [
	super onNotificationChanged.
	self message: self event message.
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
