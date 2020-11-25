Class {
	#name : #GtNotificationJob,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'job'
	],
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #comparing }
GtNotificationJob >> = anObject [
	^ self class = anObject class and: [
		self job = anObject job ]
]

{ #category : #'private - asserting' }
GtNotificationJob >> assertJob: aJob [
	self 
		assert: [ aJob isNotNil ] 
		description: [ 'Job must be non-nil' ].
	self
		assert: [ job isNil ] 
		description: [ 'Job can be initialized only once' ].
]

{ #category : #'api - accessing' }
GtNotificationJob >> elementClass [
	^ GtNotificationRootJobElement
]

{ #category : #comparing }
GtNotificationJob >> hash [
	^ self class hash bitXor: self job hash
]

{ #category : #'api - accessing' }
GtNotificationJob >> job [
	<return: #Job>
	^ job
]

{ #category : #'api - accessing' }
GtNotificationJob >> job: aJob [
	self assertJob: aJob.
	job := aJob.
	self subscribeToJob.
]

{ #category : #'private - announcement handling' }
GtNotificationJob >> onJobEnd: aJobEnd [
	self job = aJobEnd job ifFalse: [ ^ self ].
	self unsubscribeFromJob.
	self requestRemoval.
]

{ #category : #'private - subscriptions' }
GtNotificationJob >> subscribeToJob [
	self job announcer
		when: JobEnd 
		send: #onJobEnd:
		to: self.
]

{ #category : #'private - subscriptions' }
GtNotificationJob >> unsubscribeFromJob [
	self job announcer unsubscribe: self.
]
