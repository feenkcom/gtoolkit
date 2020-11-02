Class {
	#name : #GtNotificationJobEvent,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'job'
	],
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #'api - accessing' }
GtNotificationJobEvent >> elementClass [
	^ GtNotificationJobElement
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
