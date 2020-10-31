Class {
	#name : #GtNotificationDismissWish,
	#superclass : #GtNotificationWish,
	#instVars : [
		'notification'
	],
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #'private - asserting' }
GtNotificationDismissWish >> assertNotification: aGtNotificationEventElement [ 
	self 
		assert: [ aGtNotificationEventElement isNotNil ] 
		description: [ 'Notification must be non-nil' ]
]

{ #category : #'api - accessing' }
GtNotificationDismissWish >> notification [
	<return: #GtNotificationEvent>
	^ notification
]

{ #category : #'api - accessing' }
GtNotificationDismissWish >> notification: aGtNotificationEvent [
	self assertNotification: aGtNotificationEvent.
	notification := aGtNotificationEvent. 
]
