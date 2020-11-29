Class {
	#name : #GtNotificationJob,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'job',
		'state'
	],
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #comparing }
GtNotificationJob >> = anObject [
	^ self class = anObject class and: [
		self job = anObject job ]
]

{ #category : #accessing }
GtNotificationJob >> addedTo: aGtNotifications [
	super addedTo: aGtNotifications.
	self state job: self addedTo: aGtNotifications.
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

{ #category : #initialization }
GtNotificationJob >> initialize [
	super initialize.
	state := GtNotificationJobState running.
]

{ #category : #'api - accessing' }
GtNotificationJob >> job [
	<return: #Job>
	^ job
]

{ #category : #'api - accessing' }
GtNotificationJob >> job: aJob [
	"I must be initialized in the same process as the job,
	otherwise the job may finish before I subscribe to its changes."
	self assertJob: aJob.
	job := aJob.
	self subscribeToJob.
]

{ #category : #'private - announcement handling' }
GtNotificationJob >> onJobEnd: aJobEnd [
	self job = aJobEnd job ifFalse: [ ^ self ].
	state := GtNotificationJobState finished.
	self unsubscribeFromJob.
	self requestRemoval.
]

{ #category : #'private - accessing' }
GtNotificationJob >> state [
	<return: #GtNotificationJobState>
	^ state
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
