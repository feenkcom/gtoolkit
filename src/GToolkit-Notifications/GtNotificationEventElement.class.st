Class {
	#name : #GtNotificationEventElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'notification'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'api - instance creation' }
GtNotificationEventElement class >> event: aNotificationEvent [
	self 
		deprecated: 'Use #notification: instead.' 
		transformWith: '`@receiver event: `@arg' -> '`@receiver notification: `@arg'.
	^ self notification: aNotificationEvent
]

{ #category : #'api - instance creation' }
GtNotificationEventElement class >> notification: aNotificationEvent [
	^ self new notification: aNotificationEvent
]

{ #category : #'private - asserting' }
GtNotificationEventElement >> assertNotification: aGtNotificationEvent [
	self 
		assert: [ aGtNotificationEvent isNotNil ] 
		description: [ 'Notification event must be non-nil' ].
]

{ #category : #defaults }
GtNotificationEventElement >> defaultVerticalResizerModel [
	^ BrLayoutVerticalResizerModel fitContent
]

{ #category : #'api - actions' }
GtNotificationEventElement >> dismiss [
	self
		notificationDo: [ :aNotification | 
			self
				fireEvent: (GtNotificationDismissWish new notification: aNotification) ]
]

{ #category : #'api - accessing' }
GtNotificationEventElement >> event [
	<return: #GtNotificationEvent>
	self 
		deprecated: 'Use #notification instead.' 
		transformWith: '`@receiver event' -> '`@receiver notification'.
	^ self notification
]

{ #category : #'api - accessing' }
GtNotificationEventElement >> event: aGtNotification [
	self 
		deprecated: 'Use #notification: instead.' 
		transformWith: '`@receiver event: `@arg' -> '`@receiver notification: `@arg'.
	self notification: aGtNotification
]

{ #category : #'private - accessing' }
GtNotificationEventElement >> eventDo: aBlock [
	self 
		deprecated: 'Use #notificationDo: instead.' 
		transformWith: '`@receiver eventDo: `@arg' -> '`@receiver notificationDo: `@arg'.
	self notificationDo: aBlock
]

{ #category : #'api - accessing' }
GtNotificationEventElement >> notification [
	<return: #GtNotificationEvent>
	^ notification
]

{ #category : #'api - accessing' }
GtNotificationEventElement >> notification: aGtNotificationEvent [
	self assertNotification: aGtNotificationEvent.
	notification = aGtNotificationEvent ifTrue: [ ^ self ].
	self unsubscribeFromNotification.
	notification := aGtNotificationEvent.
	self subscribeToNotification.
	self onNotificationChanged.
	
]

{ #category : #'private - accessing' }
GtNotificationEventElement >> notificationDo: aBlock [
	self notification ifNotNil: aBlock
]

{ #category : #'private - hooks' }
GtNotificationEventElement >> onNotificationChanged [
	"Subclasses may react to event instance variable changes"
]

{ #category : #'private - subscriptions' }
GtNotificationEventElement >> subscribeToNotification [
	"Subclasses may subscribe to events (announcements)"
]

{ #category : #'private - subscriptions' }
GtNotificationEventElement >> unsubscribeFromNotification [
	"Subclasses may unsubscribe from events (announcements)"
]
