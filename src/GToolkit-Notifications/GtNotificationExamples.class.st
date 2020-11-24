Class {
	#name : #GtNotificationExamples,
	#superclass : #GtNotificationCommonExamples,
	#instVars : [
		'sessions'
	],
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'private - support' }
GtNotificationExamples >> addSession: aSession [
	self sessions add: aSession.
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> basicDebugSessionElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationDebugSessionElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> basicDebugSessionEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationDebugSession new.
	self assert: anEvent debugSession isNil.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - message notification' }
GtNotificationExamples >> basicMessageElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationMessageElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - message notification' }
GtNotificationExamples >> basicMessageEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationMessage new.
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
	self assert: anElement listElement notifications == anElement notifications.
	^ anElement
]

{ #category : #'examples - message notification' }
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
	anElement := GtNotificationsListElement new.
	self assert: anElement notifications size equals: 0.
	self assert: anElement listElement items size equals: 0.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> debugSession [
	<gtExample>
	<after: #terminateSessions>
	| aContext aProcess aSession |
	aContext := [ 1 + 1 ] asContext.
	aProcess := Process 
	    forContext: aContext 
	    priority: Processor userInterruptPriority.
	aSession := aProcess 
		newDebugSessionNamed: 'Example session' 
		startedAt: aContext.
	self addSession: aSession.
	^ aSession 
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> debugSessionElement [
	<gtExample>
	| anElement anEvent |
	anElement := self basicDebugSessionElement.
	anEvent := self debugSessionEvent.
	anElement notification: anEvent.
	self assert: anElement notification equals: anEvent.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> debugSessionEvent [
	<gtExample>
	| anEvent aSession |
	anEvent := self basicDebugSessionEvent.
	aSession := self sharedDebugSession.
	anEvent debugSession: aSession.
	self assert: anEvent debugSession equals: aSession.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - message notification' }
GtNotificationExamples >> messageEvent [
	<gtExample>
	| anEvent aMessage |
	anEvent := GtNotificationMessage new.
	aMessage := 'Hello Glamorous Toolkit'.
	anEvent message: aMessage.
	self assert: anEvent message equals: aMessage.
	^ anEvent
]

{ #category : #'examples - badge' }
GtNotificationExamples >> notificationBadgeElement_FiveNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_FourNotifications.
	aNotification := self debugSessionEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 5.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationExamples >> notificationBadgeElement_FourNotifications [
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
GtNotificationExamples >> notificationBadgeElement_HudredNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationBadgeElement.
	100 timesRepeat: [ 
		aNotification := self messageEvent.
		BlUseAsyncFeatures disableDuring: [
			anElement notification: aNotification ] ].
	self assert: anElement notificationsCount equals: 100.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationExamples >> notificationBadgeElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationBadgeElement.
	aNotification := self messageEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 1.
	^ anElement
]

{ #category : #'examples - badge' }
GtNotificationExamples >> notificationBadgeElement_ThreeNotifications [
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
GtNotificationExamples >> notificationBadgeElement_TwoNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationBadgeElement_OneNotification.
	aNotification := self notificationJob.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 2.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationExamples >> notificationsListElement_FiveNotifications [
	<gtExample>
	| anElement aNotification |
	anElement := self notificationsListElement_FourNotifications.
	aNotification := self debugSessionEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 5.
	self assert: anElement listElement items size equals: 5.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationExamples >> notificationsListElement_FourNotifications [
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
GtNotificationExamples >> notificationsListElement_OneNotification [
	<gtExample>
	| anElement aNotification |
	anElement := self basicNotificationsElement.
	aNotification := self messageEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 1.
	self assert: anElement listElement items size equals: 1.
	^ anElement
]

{ #category : #'examples - list' }
GtNotificationExamples >> notificationsListElement_ThreeNotifications [
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
GtNotificationExamples >> notificationsListElement_TwoNotifications [
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

{ #category : #'private - support' }
GtNotificationExamples >> sessions [
	^ sessions ifNil: [ sessions := OrderedCollection new ]
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> sharedDebugSession [
	<gtExample>
	| aSharedSession aPharoSession |
	aSharedSession := GtSharedDebugSession new.
	aPharoSession := self debugSession.
	aSharedSession session: aPharoSession.
	self assert: aSharedSession session equals: aPharoSession.
	^ aSharedSession
]

{ #category : #'private - support' }
GtNotificationExamples >> terminateSessions [
	self sessions do: [ :eachSession | 
		eachSession terminate ]
]
