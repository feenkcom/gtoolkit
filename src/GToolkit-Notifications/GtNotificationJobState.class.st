Class {
	#name : #GtNotificationJobState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'api - accessing' }
GtNotificationJobState class >> finished [
	^ GtNotificationJobFinishedState default
]

{ #category : #'api - accessing' }
GtNotificationJobState class >> running [
	^ GtNotificationJobRunningState default
]

{ #category : #'api - event managing' }
GtNotificationJobState >> job: aNotification addedTo: aGtNotifications [
	self subclassResponsibility
]
