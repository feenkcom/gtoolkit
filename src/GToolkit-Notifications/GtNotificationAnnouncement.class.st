Class {
	#name : #GtNotificationAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'notification'
	],
	#category : #'GToolkit-Notifications-Announcements'
}

{ #category : #'api - instance creation' }
GtNotificationAnnouncement class >> notification: aNotification [
	^ self new notification: aNotification
]

{ #category : #accessing }
GtNotificationAnnouncement >> notification [
	<return: #GtNotificationEvent>
	^ notification
]

{ #category : #accessing }
GtNotificationAnnouncement >> notification: aNotification [
	notification := aNotification
]
