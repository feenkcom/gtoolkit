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
	self assert: anElement listElement notifications == anElement notifications.
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

{ #category : #'examples - job' }
GtNotificationExamples >> basicNotificationJobElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationJobElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
]

{ #category : #'examples - job' }
GtNotificationExamples >> basicNotificationJobEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationJobEvent new.
	self assert: anEvent job isNil.
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

{ #category : #'examples - job' }
GtNotificationExamples >> job [
	<gtExample>
	| aJob aBlock |
	aBlock := [ :theJob |
		0 to: 1 by: 0.1 do: [ :aNumber | 
			theJob progress: aNumber ] ].
	aJob := aBlock asJob.
	aJob
		title: 'Job Progress Example';
		min: 0;
		max: 1.
	self assert: aJob progress equals: 0.
	
	aJob progress: 0.3.
	self assert: aJob progress equals: 0.3.
	
	^ aJob
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

{ #category : #accessing }
GtNotificationExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
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

{ #category : #accessing }
GtNotificationExamples >> notificationJobElement [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobElement.
	anEvent := self notificationJobEvent.
	anElement event: anEvent.
	
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.

	^ anElement
]

{ #category : #accessing }
GtNotificationExamples >> notificationJobElement_runningJob [
	<gtExample>
	| anElement aJob aSemaphore aSpace aTimeout anElementSubscriptions |
	aSemaphore := Semaphore new.
	anElement := self notificationJobElement.
	aJob := anElement event job.

	anElementSubscriptions := OrderedCollection new.
	aJob announcer subscriptions
		subscriptionsOf: anElement 
		do: [ :aSubscription |
			anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 0.
	
	aSpace := self newSpace.	
	aSpace addChild: anElement.

	aJob announcer subscriptions
		subscriptionsOf: anElement 
		do: [ :aSubscription |
			anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 2.
	
	aJob run.

	self assert: aJob isRunning not.
	self assert: aJob progress > 0.99.

	anElement enqueueTask: (BlTaskAction new 
		action: [ aSemaphore signal ]).
	aSpace pulse.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	
	self 
		assert: aTimeout not 
		description: [ 'Semaphore timeout' ].
	self 
		assert: anElement progressElement fraction > 0.99
		description: [ 'Progress must be updated' ].	
		
	anElement removeFromParent.

	anElementSubscriptions := OrderedCollection new.
	aJob announcer subscriptions
		subscriptionsOf: anElement 
		do: [ :aSubscription |
			anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 0.	
	^ anElement
]

{ #category : #'examples - job' }
GtNotificationExamples >> notificationJobEvent [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJobEvent.
	aJob := self job.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
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
