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

{ #category : #'examples - notifications' }
GtNotificationsExamples >> jobNotification [
	<gtExample>
	^ GtNotificationJobExamples new notificationJobWithTwoChildren
]

{ #category : #'examples - notifications' }
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

{ #category : #'examples - notifications' }
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

{ #category : #'examples - notifications' }
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
