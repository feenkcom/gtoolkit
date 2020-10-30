Class {
	#name : #GtNotificationExamples,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - events' }
GtNotificationExamples >> basicMessageEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationMessageEvent new.
	self assert: anEvent message isString.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - badge' }
GtNotificationExamples >> basicNotificationBadgeElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationsBadgeElement new.
	self assert: anElement notificationsCount equals: 0.
	^ anElement
]

{ #category : #'examples - events' }
GtNotificationExamples >> basicNotificationEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationEvent new.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - list' }
GtNotificationExamples >> basicNotificationsElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationsElement new.
	self assert: anElement notifications size equals: 0.
	self assert: anElement listElement items size equals: 0.
	^ anElement
]

{ #category : #'examples - events' }
GtNotificationExamples >> messageEvent [
	<gtExample>
	| anEvent aMessage |
	anEvent := GtNotificationMessageEvent new.
	aMessage := 'Hello Glamorous Toolkit'.
	anEvent message: aMessage.
	self assert: anEvent message equals: aMessage.
	^ anEvent
]

{ #category : #'examples - badge' }
GtNotificationExamples >> notificationBadgeElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationBadgeElement.
	aNotification := self messageEvent.
	anElement notification: aNotification.
	self assert: anElement notificationsCount equals: 1.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationExamples >> notificationsElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationsElement.
	aNotification := self messageEvent.
	anElement notification: aNotification.
	self assert: anElement notifications size equals: 1.
	self assert: anElement listElement items size equals: 1.
	^ anElement
]
