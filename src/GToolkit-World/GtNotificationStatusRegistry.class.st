"
I provide support for marking news in the home screen as viewed.

I hold a list of status objects for neews and know how to persists it and read it from a STON preference file. For news that are viewed I return a ${class:GtNotificationViewedStatus}$. Otherwise if no status was saved for a news I return a status of type ${class:GtNotificationNullStatus}$.
"
Class {
	#name : #GtNotificationStatusRegistry,
	#superclass : #GtInteractiveStatusRegistry,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationStatusRegistry class >> currentSchemaVersion [
	^ 'v1'
]

{ #category : #accessing }
GtNotificationStatusRegistry class >> registryFileName [
	^ 'com.glamoroustoolkit.notification-statuses'
]
