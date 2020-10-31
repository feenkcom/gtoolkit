Class {
	#name : #GtNotificationEventElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'event'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #'api - instance creation' }
GtNotificationEventElement class >> event: aNotificationEvent [
	^ self new event: aNotificationEvent
]

{ #category : #'private - asserting' }
GtNotificationEventElement >> assertEvent: aGtNotificationEvent [
	self 
		assert: [ aGtNotificationEvent isNotNil ] 
		description: [ 'Notification event must be non-nil' ].
]

{ #category : #defaults }
GtNotificationEventElement >> defaultVercialResizerModel [
	^ BrLayoutVerticalResizerModel fitContent
]

{ #category : #'api - actions' }
GtNotificationEventElement >> dismiss [
	self fireEvent: (GtNotificationDismissWish new notification: self event)
]

{ #category : #accessing }
GtNotificationEventElement >> event [
	<return: #GtNotificationEvent>
	^ event
]

{ #category : #accessing }
GtNotificationEventElement >> event: aGtNotificationEvent [
	self assertEvent: aGtNotificationEvent.
	event = aGtNotificationEvent ifTrue: [ ^ self ].
	event := aGtNotificationEvent.
	self onEventChanged.
	
]

{ #category : #'private - hooks' }
GtNotificationEventElement >> onEventChanged [
	"Subclasses may react to event instance variable changes"
]
