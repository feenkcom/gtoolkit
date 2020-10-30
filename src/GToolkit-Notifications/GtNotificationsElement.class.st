Class {
	#name : #GtNotificationsElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'notifications',
		'listElement'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #initialization }
GtNotificationsElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #defaults }
GtNotificationsElement >> defaultNotifications [
	^ LinkedList new
]

{ #category : #initialization }
GtNotificationsElement >> initialize [
	super initialize.
	notifications := self defaultNotifications.
	self initializeList.
	
	self addChild: self listElement as: #notifications.
	
	self addLook: (BrLayoutResizerLook inherit
		inherit: self listElement).
]

{ #category : #initialization }
GtNotificationsElement >> initializeList [
	listElement := BrSimpleList new
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex |
			anItemObject elementClass ];
		itemStencil: [ :anItemType :aListWidget |
			anItemType new ];
		itemDataBinder: [ :anItemElement :anItemObject :anItemIndex |
			anItemElement event: anItemObject ];
		items: self notifications.
]

{ #category : #'private - accessing' }
GtNotificationsElement >> listElement [
	<return: #BrSimpleList>
	^ listElement
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notification: aNotification [
	self notifications addFirst: aNotification.
	self onNotificationsChanged.
]

{ #category : #'private - accessing' }
GtNotificationsElement >> notifications [
	<return: #SequenceableCollection of: #GtNotificationEvent>
	^ notifications
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notificationsCount [
	<return: #Integer>
	^ self notifications size
]

{ #category : #'private - hooks' }
GtNotificationsElement >> onNotificationsChanged [
	self enqueueTask: (BlTaskAction new
		action: [ self updateList ])
]

{ #category : #'private - updating' }
GtNotificationsElement >> updateList [
	"I must be called in a UI process."
	self listElement items: self notifications.
]
