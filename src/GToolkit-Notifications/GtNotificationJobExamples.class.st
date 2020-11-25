Class {
	#name : #GtNotificationJobExamples,
	#superclass : #GtNotificationCommonExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - notification' }
GtNotificationJobExamples >> basicNotificationJob [
	<gtExample>
	| anEvent |
	anEvent := GtNotificationJob new.
	self assert: anEvent job isNil.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> basicNotificationJobElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationJobElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
]

{ #category : #'examples - notification' }
GtNotificationJobExamples >> basicNotificationJobWithChildrenElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationJobWithChildrenElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> basicNotificationRootJobElement [
	<gtExample>
	| anElement aCurrentJob |
	anElement := GtNotificationRootJobElement new.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: 42.
	^ anElement
]

{ #category : #'examples - job' }
GtNotificationJobExamples >> job [
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

{ #category : #'examples - job' }
GtNotificationJobExamples >> jobAt: theIntermittentNumbers do: anIntermittentBlock [
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

{ #category : #'examples - job' }
GtNotificationJobExamples >> jobWithChild [
	<gtExample>
	| aParentJob aChildJob |
	aParentJob := self job.
	aChildJob := self job
		title: 'Sub-Job One'.
	aParentJob addChild: aChildJob.
	
	^ aParentJob
]

{ #category : #'examples - job' }
GtNotificationJobExamples >> jobWithTwoChildren [
	<gtExample>
	| aParentJob aChildJob |
	aParentJob := self jobWithChild.
	aChildJob := self job
		title: 'Sub-Job Two'.
	aParentJob addChild: aChildJob.
	
	^ aParentJob
]

{ #category : #'examples - notification' }
GtNotificationJobExamples >> notificationJob [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJob.
	aJob := self job.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> notificationJobElement [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobElement.
	anEvent := self notificationJob.
	anElement notification: anEvent.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.
	^ anElement
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> notificationJobElement_runningJob [
	<gtExample>
	| anElement aJob aSemaphore aSpace aTimeout anElementSubscriptions |
	aSemaphore := Semaphore new.
	anElement := self notificationJobElement.
	aJob := anElement notification job.
	anElementSubscriptions := OrderedCollection new.
	aJob announcer subscriptions
		subscriptionsOf: anElement
		do: [ :aSubscription | anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 0.
	aSpace := self newSpace.
	aSpace addChild: anElement.
	aJob announcer subscriptions
		subscriptionsOf: anElement
		do: [ :aSubscription | anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 2.
	aJob run.
	self assert: aJob isRunning not.
	self assert: aJob progress > 0.99.
	anElement
		enqueueTask: (BlTaskAction new action: [ aSemaphore signal ]).
	aSpace pulse.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self assert: aTimeout not description: [ 'Semaphore timeout' ].
	self
		assert: anElement progressElement fraction > 0.99
		description: [ 'Progress must be updated' ].
	anElement removeFromParent.
	anElementSubscriptions := OrderedCollection new.
	aJob announcer subscriptions
		subscriptionsOf: anElement
		do: [ :aSubscription | anElementSubscriptions add: aSubscription ].
	self assert: anElementSubscriptions size equals: 0.
	^ anElement
]

{ #category : #'examples - notification' }
GtNotificationJobExamples >> notificationJobWithChild [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJob.
	aJob := self jobWithChild.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> notificationJobWithChildrenElement [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobWithChildrenElement.
	anEvent := self notificationJob.
	anElement notification: anEvent.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.
	^ anElement
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> notificationJobWithChildrenElement_OneChild [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationJobWithChildrenElement.
	anEvent := self notificationJob.
	anEvent job addChild: (self job title: 'Sub-Job Progress').
	anElement notification: anEvent.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.
	^ anElement
]

{ #category : #'examples - notification' }
GtNotificationJobExamples >> notificationJobWithTwoChildren [
	<gtExample>
	| anEvent aJob |
	anEvent := self basicNotificationJob.
	aJob := self jobWithTwoChildren.
	anEvent job: aJob.
	self assert: anEvent job equals: aJob.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - element' }
GtNotificationJobExamples >> notificationRootJobElement [
	<gtExample>
	| anElement anEvent aCurrentJob |
	anElement := self basicNotificationRootJobElement.
	anEvent := self notificationJob.
	anElement notification: anEvent.
	aCurrentJob := 42.
	anElement jobDo: [ :aJob | aCurrentJob := aJob ].
	self assert: aCurrentJob equals: anEvent job.
	^ anElement
]

{ #category : #'examples - job' }
GtNotificationJobExamples >> parentJob [
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

{ #category : #'examples - notification' }
GtNotificationJobExamples >> removalRequestAnnouncement [
	<gtExample>
	| aJobNotification aJob aCollection |
	aJobNotification := self notificationJob.
	aJob := aJobNotification job.

	aCollection := OrderedCollection new.
	aJobNotification onRemovalRequestSend: #add: to: aCollection.
		
	aJob run.
	
	self assert: aCollection size equals: 1.
	self assert: aCollection anyOne notification equals: aJobNotification.

	^ aJobNotification
]

{ #category : #'examples - notification' }
GtNotificationJobExamples >> requestRemoval [
	<gtExample>
	| aNotification aCollection |
	aCollection := OrderedCollection new.
	aNotification := self notificationJob.
	aNotification onRemovalRequestSend: #add: to: aCollection.

	aNotification requestRemoval.
	
	self assert: aCollection size equals: 1.
	self assert: aCollection first notification equals: aNotification.
	self assert: aNotification job isNotNil.
	self assert: (aNotification asElement isKindOf: BlElement).
	^ aNotification
]
