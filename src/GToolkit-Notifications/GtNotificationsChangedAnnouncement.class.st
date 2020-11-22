"
I am an ${class:Announcement}$.
I am announced by ${class:GtNotifications}$ when a ${class:GtNotificationEvent}$ is added.

"
Class {
	#name : #GtNotificationsChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'notifications'
	],
	#category : #'GToolkit-Notifications-Announcements'
}

{ #category : #'api - accessing' }
GtNotificationsChangedAnnouncement >> notifications [
	<return: #GtNotifications>
	^ notifications
]

{ #category : #'api - accessing' }
GtNotificationsChangedAnnouncement >> notifications: aGtNotications [
	notifications := aGtNotications
]
