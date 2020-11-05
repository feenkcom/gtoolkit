Class {
	#name : #GtNotificationExamples,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - debug session' }
GtNotificationExamples >> basicDebugSessionElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationDebugSessionElement new.
	self assert: anElement event isNil.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> basicDebugSessionEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationDebugSessionEvent new.
	self assert: anEvent debugSession isNil.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - message notification' }
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

{ #category : #'examples - message notification' }
GtNotificationExamples >> basicNotificationEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationEvent new.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> basicNotificationJobElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationJobElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> basicNotificationJobEvent [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationJobEvent new.
	self assert: anEvent job isNil.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> basicNotificationJobWithChildrenElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationJobWithChildrenElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
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
	| aContext aProcess aSession |
	aContext := [ 1 + 1 ] asContext.
	aProcess := Process 
	    forContext: aContext 
	    priority: Processor userInterruptPriority.
	aSession := aProcess 
		newDebugSessionNamed: 'Example session' 
		startedAt: aContext.
	^ aSession 
]

{ #category : #'examples - debug session' }
GtNotificationExamples >> debugSessionElement [
	<gtExample>
	| anElement anEvent |
	anElement := self basicDebugSessionElement.
	anEvent := self debugSessionEvent.
	anElement event: anEvent.
	self assert: anElement event equals: anEvent.
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

{ #category : #'examples - job notification' }
GtNotificationExamples >> job [
	<gtExample>
	| aJob aBlock |
	aBlock := [ :theJob |
		0 to: 1 by: 0.1 do: [ :aNumber | 
			theJob progress: aNumber ] ].
	aJob := aBlock asJob.
	aJob
		title: 'Job Progress';
		min: 0;
		max: 1.
	self assert: aJob progress equals: 0.
	
	aJob progress: 0.3.
	self assert: aJob progress equals: 0.3.
	
	^ aJob
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> jobAt: theIntermittentNumbers do: anIntermittentBlock [
	<gtExample>
	| aJob aBlock |
	aBlock := [ :theJob |
		0 to: 1 by: 0.1 do: [ :aNumber | 
			theJob progress: aNumber.
			(theIntermittentNumbers includes: aNumber) ifTrue: [ 
				anIntermittentBlock cull: aNumber ] ] ].
	aJob := aBlock asJob.
	aJob
		title: 'Job Progress INterrmittent Example';
		min: 0;
		max: 1.
	self assert: aJob progress equals: 0.
	
	^ aJob
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> jobWithChild [
	<gtExample>
	| aParentJob aChildJob |
	aParentJob := self job.
	aChildJob := self job
		title: 'Sub-Job One'.
	aParentJob addChild: aChildJob.
	
	^ aParentJob
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> jobWithTwoChildren [
	<gtExample>
	| aParentJob aChildJob |
	aParentJob := self jobWithChild.
	aChildJob := self job
		title: 'Sub-Job Two'.
	aParentJob addChild: aChildJob.
	
	^ aParentJob
]

{ #category : #'examples - message notification' }
GtNotificationExamples >> messageEvent [
	<gtExample>
	| anEvent aMessage |
	anEvent := GtNotificationMessageEvent new.
	aMessage := 'Hello Glamorous Toolkit'.
	anEvent message: aMessage.
	self assert: anEvent message equals: aMessage.
	^ anEvent
]

{ #category : #'examples - support' }
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
	aNotification := self notificationJobWithTwoChildrenEvent.
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
	aNotification := self notificationJobWithChildEvent.
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
	aNotification := self notificationJobEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notificationsCount equals: 2.
	^ anElement
]

{ #category : #'examples - job notification' }
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

{ #category : #'examples - job notification' }
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

{ #category : #'examples - job notification' }
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

{ #category : #'examples - job notification' }
GtNotificationExamples >> notificationJobWithChildEvent [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJobEvent.
	aJob := self jobWithChild.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> notificationJobWithChildrenElement [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobWithChildrenElement.
	anEvent := self notificationJobEvent.
	anElement event: anEvent.
	
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.

	^ anElement
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> notificationJobWithChildrenElement_OneChild [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobWithChildrenElement.
	anEvent := self notificationJobEvent.
	anEvent job addChild: (self job
		title: 'Sub-Job Progress').
	anElement event: anEvent.
	
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.

	^ anElement
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> notificationJobWithTwoChildrenEvent [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJobEvent.
	aJob := self jobWithTwoChildren.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
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
	aNotification := self notificationJobWithTwoChildrenEvent.
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
	aNotification := self notificationJobWithChildEvent.
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
	aNotification := self notificationJobEvent.
	BlUseAsyncFeatures disableDuring: [
		anElement notification: aNotification ].
	self assert: anElement notifications size equals: 2.
	self assert: anElement listElement items size equals: 2.
	^ anElement
]

{ #category : #'examples - job notification' }
GtNotificationExamples >> parentJob [
	<gtExample>
	| aJob aBlock |
	aBlock := [ :theJob |
		0 to: 1 by: 0.1 do: [ :aNumber | 
			theJob progress: aNumber.
			300 milliSeconds wait.
			"Run a child job"
			aNumber = 0.5 ifTrue: [ 
				self job run ] ] ].
	
	aJob := aBlock asJob.
	aJob
		title: 'Job Parent Progress Example';
		min: 0;
		max: 1.

	self assert: aJob progress equals: 0.
	
	aJob progress: 0.3.
	self assert: aJob progress equals: 0.3.
	
	^ aJob
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
