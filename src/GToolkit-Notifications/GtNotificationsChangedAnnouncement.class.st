"
I am an {{gtClass:Announcement}}.
I am announced by {{gtClass:GtNotifications}} when a {{gtClass:GtNotificationEvent}} is added.


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
