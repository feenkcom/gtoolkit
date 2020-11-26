Class {
	#name : #GtNotificationsBadgeElementExamples,
	#superclass : #GtNotificationsElementExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> basicNotificationBadgeElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationsBadgeElement new.
	self assert: anElement notificationsCount equals: 0.
	self assert: anElement listElement notifications == anElement notifications.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_FiveNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_FourNotifications.
	aNotification := self debugSessionNotification.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 5.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_FourNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_ThreeNotifications.
	aNotification := self notificationJobWithTwoChildren.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 4.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_HudredNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationBadgeElement.
	100 timesRepeat: [ 
		aNotification := self notificationMessage.
		BlUseAsyncFeatures disableDuring: [
			anElement notification: aNotification ] ].
	self assert: anElement notificationsCount equals: 100.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationBadgeElement.
	aNotification := self notificationMessage.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 1.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_ThreeNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_TwoNotifications.
	aNotification := self notificationJobWithChild.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 3.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationsBadgeElementExamples >> notificationBadgeElement_TwoNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_OneNotification.
	aNotification := self notificationJob.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 2.
	^ anElement
]
