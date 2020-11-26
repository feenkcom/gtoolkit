Class {
	#name : #GtNotificationsListElementExamples,
	#superclass : #GtNotificationsElementExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> basicNotificationsElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationsListElement new.
	self assert: anElement notifications size equals: 0.
	self assert: anElement listElement items size equals: 1.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> notificationsListElement_FiveNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationsListElement_FourNotifications.
	aNotification := self debugSessionNotification.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 5.
	self assert: anElement listElement items size equals: 5.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> notificationsListElement_FourNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationsListElement_ThreeNotifications.
	aNotification := self notificationJobWithTwoChildren.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 4.
	self assert: anElement listElement items size equals: 4.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> notificationsListElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationsElement.
	aNotification := self notificationMessage.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 1.
	self assert: anElement listElement items size equals: 1.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> notificationsListElement_ThreeNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationsListElement_TwoNotifications.
	aNotification := self notificationJobWithChild.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 3.
	self assert: anElement listElement items size equals: 3.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationsListElementExamples >> notificationsListElement_TwoNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationsListElement_OneNotification.
	aNotification := self notificationJob.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 2.
	self assert: anElement listElement items size equals: 2.
	^ anElement
]
