"
I am status indicating that a notification has been viewed by the user.
"
Class {
	#name : #GtNotificationViewedStatus,
	#superclass : #GtNotificationStatus,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationViewedStatus class >> registryValue [
	^ 'viewed'
]

{ #category : #testing }
GtNotificationViewedStatus >> isViewed [
	^ true
]
