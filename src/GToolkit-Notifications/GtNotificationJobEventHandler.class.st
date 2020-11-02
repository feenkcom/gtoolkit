Class {
	#name : #GtNotificationJobEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'private - accessing' }
GtNotificationJobEventHandler >> defaultElementAndSpaceDo: aBlock [
	self elementAndSpaceDo: [ :anElement :aSpace | 
		"Proceed only if in a default space (world)"
		aSpace id = GtWorld defaultId ifFalse: [ ^ self ].
		aBlock cull: anElement cull: aSpace ]
]

{ #category : #'private - accessing' }
GtNotificationJobEventHandler >> elementAndSpaceDo: aBlock [
	self elementDo: [ :anElement | 
		anElement space ifNotNil: [ :aSpace | 
			aBlock cull: anElement cull: aSpace ] ]
]

{ #category : #'private - accessing' }
GtNotificationJobEventHandler >> elementDo: aBlock [
	element ifNotNil: aBlock
]

{ #category : #'api - accessing' }
GtNotificationJobEventHandler >> eventsToHandle [
	^ Array 
		with: BlElementAddedToSceneGraphEvent 
		with: BlElementRemovedFromSceneGraphEvent
]

{ #category : #'api - event managing' }
GtNotificationJobEventHandler >> handleEvent: anEvent [
	anEvent accept: self.
]

{ #category : #'api - hooks' }
GtNotificationJobEventHandler >> onInstalledIn: anObject [
	super onInstalledIn: anObject.
	element := anObject.
	anObject isAttachedToSceneGraph ifTrue: [ 
		self subscribeToJobs ].
]

{ #category : #'private - announcement handling' }
GtNotificationJobEventHandler >> onJobEnd: aJobStart [
	"I remove the notification only in the default world (space)"
	self defaultElementAndSpaceDo: [ :anElement :aSpace | 
		| aNotification |
		
		aNotification := GtNotificationJobEvent new 
			job: aJobStart job.
		anElement removeNotification: aNotification.
	]
]

{ #category : #'private - announcement handling' }
GtNotificationJobEventHandler >> onJobStart: aJobStart [
	"I show the notification only in the default world (space)"
	self defaultElementAndSpaceDo: [ :anElement :aSpace | 
		| aNotification |
		
		aNotification := GtNotificationJobEvent new 
			job: aJobStart job.
		anElement showNotification: aNotification.
	]
]

{ #category : #'api - hooks' }
GtNotificationJobEventHandler >> onUninstalledIn: anObject [
	self unsubscribeFromJobs.
	element := nil.
]

{ #category : #'private - subscriptions' }
GtNotificationJobEventHandler >> subscribeToJobs [
	Job jobAnnouncer
		when: JobStart
		send: #onJobStart:
		to: self;
		when: JobEnd
		send: #onJobEnd:
		to: self.
]

{ #category : #'private - subscriptions' }
GtNotificationJobEventHandler >> unsubscribeFromJobs [
	Job jobAnnouncer unsubscribe: self.
]

{ #category : #visiting }
GtNotificationJobEventHandler >> visitElementAddedToSceneGraphEvent: anEvent [
	self subscribeToJobs
]

{ #category : #accessing }
GtNotificationJobEventHandler >> visitElementRemovedFromSceneGraphEvent: anEvent [
	self unsubscribeFromJobs
]

{ #category : #'api - event managing' }
GtNotificationJobEventHandler >> wantsEvent: anEvent [
	^ self eventsToHandle anySatisfy: [ :aClass | 
		anEvent isKindOf: aClass ] 
]
