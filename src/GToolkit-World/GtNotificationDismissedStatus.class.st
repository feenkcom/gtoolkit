Class {
	#name : #GtNotificationDismissedStatus,
	#superclass : #GtNotificationStatus,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationDismissedStatus class >> registryValue [
	^ 'dismissed'
]

{ #category : #testing }
GtNotificationDismissedStatus >> isDismissed [
	^ true
]
