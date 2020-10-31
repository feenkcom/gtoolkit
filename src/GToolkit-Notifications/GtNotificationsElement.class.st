Class {
	#name : #GtNotificationsElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'notifications',
		'updateRequester'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'private - asserting' }
GtNotificationsElement >> assertNotifications: aGtNotifications [ 
	self 
		assert: [ aGtNotifications isNotNil ] 
		description: [ 'Notifications must be non-nil' ].
]

{ #category : #initialization }
GtNotificationsElement >> initialize [
	super initialize.
	notifications := GtNotifications new.
	updateRequester := GtPhlowUpdateRequester new 
		element: self selector: #updateElement.
		
	self subscribeToNotifications.
]

{ #category : #'api - adding / removing' }
GtNotificationsElement >> notification: aNotification [
	self notifications addNotification: aNotification.
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notifications [
	<return: #GtNotifications>
	^ notifications
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notifications: aGtNotifications [
	self assertNotifications: aGtNotifications.
	notifications = aGtNotifications ifTrue: [ ^ self ].
	self unsubscribeFromNotifications.
	notifications := aGtNotifications.
	self subscribeToNotifications.
	self onNotificationsChanged.
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notificationsCount [
	<return: #Integer>
	^ self notifications size
]

{ #category : #'private - hooks' }
GtNotificationsElement >> onNotificationsChanged [
	self updateElement.
]

{ #category : #'api - adding / removing' }
GtNotificationsElement >> removeNotification: aGtNotificationEvent [ 
	self notifications removeNotification: aGtNotificationEvent
]

{ #category : #'private - updating' }
GtNotificationsElement >> requestUpdate [
	self haltOnce.
	self updateRequester requestUpdate.
]

{ #category : #'private - subscriptions' }
GtNotificationsElement >> subscribeToNotifications [
	self notifications 
		when: GtNotificationsChangedAnnouncement
		send: #requestUpdate
		to: self
]

{ #category : #'private - subscriptions' }
GtNotificationsElement >> unsubscribeFromNotifications [
	self notifications ifNotNil: [ :anAnnouncer | 
		anAnnouncer unsubscribe: self ].
]

{ #category : #'private - updating' }
GtNotificationsElement >> updateElement [
	"Subclasses may update their widgets"
]

{ #category : #'private - accessing' }
GtNotificationsElement >> updateRequester [
	<return: #GtPhlowUpdateRequester>
	^ updateRequester
]
