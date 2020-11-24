Class {
	#name : #GtNotificationJobObserver,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'class initialization' }
GtNotificationJobObserver class >> initialize [
	self default subscribeToJobs.
]

{ #category : #'private - hooks' }
GtNotificationJobObserver class >> onRemoveUniqueInstance: anInstance [
	anInstance unsubscribeFromJobs
]

{ #category : #initialization }
GtNotificationJobObserver class >> unload [
	self cleanUniqueInstance.
	super unload.
]

{ #category : #'private - testing' }
GtNotificationJobObserver >> isRootJob: aJob [
	(aJob isKindOf: Job) ifFalse: [ ^ true ].
	^ aJob parent isNil
]

{ #category : #'private - announcement handling' }
GtNotificationJobObserver >> onJobEnd: aJobEnd [
	| aNotification |
	
	(self isRootJob: aJobEnd job) ifFalse: [ ^ self ].

	aNotification := GtNotificationJob new 
		job: aJobEnd job.
	
	GtNotificationForwarder removeNotification: aNotification.
]

{ #category : #'private - announcement handling' }
GtNotificationJobObserver >> onJobStart: aJobStart [
	| aNotification |

	(self isRootJob: aJobStart job) ifFalse: [ ^ self ].

	aNotification := GtNotificationJob new 
		job: aJobStart job.
		
	GtNotificationForwarder showNotification: aNotification.
]

{ #category : #'private - subscriptions' }
GtNotificationJobObserver >> subscribeToJobs [
	self unsubscribeFromJobs.
	Job jobAnnouncer
		when: JobStart
		send: #onJobStart:
		to: self;
		when: JobEnd
		send: #onJobEnd:
		to: self.
]

{ #category : #'private - subscriptions' }
GtNotificationJobObserver >> unsubscribeFromJobs [
	Job jobAnnouncer unsubscribe: self.
]
