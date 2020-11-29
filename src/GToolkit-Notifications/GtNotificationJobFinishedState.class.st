Class {
	#name : #GtNotificationJobFinishedState,
	#superclass : #GtNotificationJobState,
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'api - event managing' }
GtNotificationJobFinishedState >> job: aNotification addedTo: aGtNotifications [
	aNotification requestRemoval.
]
