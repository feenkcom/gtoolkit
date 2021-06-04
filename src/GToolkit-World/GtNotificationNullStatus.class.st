"
I am a null status, indicating that a notification does not have a status. I am the default status of a notification. 
"
Class {
	#name : #GtNotificationNullStatus,
	#superclass : #GtNotificationStatus,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationNullStatus class >> registryValue [
	^ 'null'
]
