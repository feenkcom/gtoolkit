Class {
	#name : #GtNotificationsBadgeElement,
	#superclass : #GtNotificationsElement,
	#instVars : [
		'listElement',
		'badgeElement',
		'dropdownBadgeElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> badgeElement [
	<return: #BrBadge>
	^ badgeElement
]

{ #category : #defaults }
GtNotificationsBadgeElement >> defaultHorizontalResizerModel [
	^ BrLayoutHorizontalResizerModel fitContent
]

{ #category : #initialization }
GtNotificationsBadgeElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #defaults }
GtNotificationsBadgeElement >> defaultVercialResizerModel [
	^ BrLayoutVerticalResizerModel fitContent
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> dropdownBadgeElement [
	<return: #BrBadge>
	^ dropdownBadgeElement
]

{ #category : #'api - visibility' }
GtNotificationsBadgeElement >> hide [
	^ self visibility: BlVisibility hidden
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initialize [
	super initialize.
	self initializeListElement.
	self initializeDropdownBadgeElement.
	self initializeBadgeElement.
	
	self addChild: self badgeElement as: #badge.
	
	self addLook: (BrLayoutResizerLook new
		anyToFitContent: self).
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeBadgeElement [
	badgeElement := self newBadge
		label: '0';
		addLook: (BrGlamorousWithDropdownLook
			handle: [ self newDropdownBadge ]
			content: [ self newDropdownContent ])
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeDropdownBadgeElement [
	dropdownBadgeElement := self newBadge
		label: '0'
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeListElement [
	listElement := GtNotificationsListElement new
		hExact: 300;
		vFitContentLimited;
		margin: (BlInsets top: 5 right: 0 bottom: 5 left: 0);
		notifications: self notifications.
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> listElement [
	<return: #GtNotificationsListElement>
	^ listElement.
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newBadge [
	^ BrBadge new
		look: BrGlamorousBadgeWithLabelLook;
		exact: 21@21
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownBadge [
	^ self dropdownBadgeElement
		removeFromParent
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownContent [
	^ self listElement
		removeFromParent
]

{ #category : #accessing }
GtNotificationsBadgeElement >> onNotificationsChanged [
	super onNotificationsChanged.
	self listElement notifications: self notifications.
]

{ #category : #'api - visibility' }
GtNotificationsBadgeElement >> show [
	^ self visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateElement [
	super updateElement.
	self badgeElement label: self notificationsCount.
	self dropdownBadgeElement label: self notificationsCount.
	self updateVisibility
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateVisibility [
	self notificationsCount isZero
		ifTrue: [ self hide ]
		ifFalse: [ self show ]
]
