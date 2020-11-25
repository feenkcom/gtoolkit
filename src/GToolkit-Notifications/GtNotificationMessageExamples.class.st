Class {
	#name : #GtNotificationMessageExamples,
	#superclass : #GtNotificationCommonExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - message notification' }
GtNotificationMessageExamples >> basicMessageElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationMessageElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - message notification' }
GtNotificationMessageExamples >> basicMessageEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationMessage new.
	self assert: anEvent message isString.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - message notification' }
GtNotificationMessageExamples >> basicNotificationEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationEvent new.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - message notification' }
GtNotificationMessageExamples >> notificationMessage [
	<gtExample>
	| anEvent aMessage |
	anEvent := GtNotificationMessage new.
	aMessage := 'Hello Glamorous Toolkit'.
	anEvent message: aMessage.
	self assert: anEvent message equals: aMessage.
	^ anEvent
]
