Class {
	#name : #GtNotificationRootJobElement,
	#superclass : #GtNotificationAbstractJobElement,
	#instVars : [
		'borderElement',
		'jobElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - accessing' }
GtNotificationRootJobElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #initialization }
GtNotificationRootJobElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtNotificationRootJobElement >> initialize [
	super initialize.
	self initializeBorderElement.
	self initializeJobElement.
	
	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer addChild: self jobElement as: #job ].
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self borderElement;
		vAnyToFitContent: self borderElement;
		hInherit: self jobElement;
		vAnyToFitContent: self jobElement).
]

{ #category : #initialization }
GtNotificationRootJobElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
]

{ #category : #initialization }
GtNotificationRootJobElement >> initializeJobElement [
	jobElement := GtNotificationJobWithChildrenElement new.
]

{ #category : #'private - accessing' }
GtNotificationRootJobElement >> jobElement [
	<return: #GtNotificationJobWithChildrenElement>
	^ jobElement
]

{ #category : #initialization }
GtNotificationRootJobElement >> onNotificationChanged [
	super onNotificationChanged.
	self jobElement notification: self notification.
]
