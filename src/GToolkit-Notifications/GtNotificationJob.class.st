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
	job := aJob.
]
