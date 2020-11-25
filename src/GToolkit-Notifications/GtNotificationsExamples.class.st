Class {
	#name : #GtNotificationsExamples,
	#superclass : #GtNotificationCommonExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - notifications' }
GtNotificationsExamples >> emptyNotifications [
	<gtExample>
	| aCollection |
	aCollection := GtNotifications new.
	self assert: aCollection asArray isEmpty.
	^ aCollection
]

{ #category : #'examples - job' }
GtNotificationsExamples >> jobNotification [
	<gtExample>
	^ GtNotificationJobExamples new notificationJobWithTwoChildren
]

{ #category : #'examples - job' }
GtNotificationsExamples >> notificationsWithJob [
	<gtExample>
	| aCollection aNotification |
	aCollection := self emptyNotifications.
	aNotification := self jobNotification.
	aCollection addNotification: aNotification.
	self assert: aCollection asArray size equals: 1.
	self assert: aCollection asArray anyOne equals: aNotification.
	self assert: (aNotification hasSubscriber: aCollection).
	^ aCollection
]

{ #category : #'examples - job' }
GtNotificationsExamples >> notificationsWithJob_Run [
	<gtExample>
	| aNotifications aJobNotification aJob |
	aNotifications := self notificationsWithJob.
	aJobNotification := aNotifications asArray first.
	aJob := aJobNotification job.
	
	aJob run.
	
	self assert: aNotifications asArray isEmpty.
	^ aNotifications
]

{ #category : #'examples - job' }
GtNotificationsExamples >> removeJobNotification [
	<gtExample>
	| aCollection aNotification |
	aCollection := self notificationsWithJob.
	aNotification := aCollection asArray anyOne.
	aCollection removeNotification: aNotification.
	self assert: aCollection asArray size equals: 0.
	self assert: (aNotification hasSubscriber: aCollection) not.
	^ aCollection
]

{ #category : #'examples - job' }
GtNotificationsExamples >> requestJobNotificationRemoval [
	<gtExample>
	| aCollection aNotification |
	aCollection := self notificationsWithJob.
	aNotification := aCollection asArray anyOne.
	aNotification requestRemoval.
	self assert: aCollection asArray size equals: 0.
	self assert: (aNotification hasSubscriber: aCollection) not.
	^ aCollection
]
