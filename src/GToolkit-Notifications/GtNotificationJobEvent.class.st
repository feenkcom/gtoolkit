Class {
	#name : #GtNotificationJobEvent,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'job'
	],
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #comparing }
GtNotificationJobEvent >> = anObject [
	^ self class = anObject class and: [
		self job = anObject job ]
]

{ #category : #'api - accessing' }
GtNotificationJobEvent >> elementClass [
	^ GtNotificationJobWithChildrenElement
]

{ #category : #comparing }
GtNotificationJobEvent >> hash [
	^ self class hash bitXor: self job hash
]

{ #category : #'api - accessing' }
GtNotificationJobEvent >> job [
	<return: #Job>
	^ job
]

{ #category : #'api - accessing' }
GtNotificationJobEvent >> job: aJob [
	job := aJob.
]
