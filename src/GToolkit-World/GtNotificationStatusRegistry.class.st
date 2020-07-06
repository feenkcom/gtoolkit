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

{ #category : #accessing }
GtNotificationStatusRegistry >> defaultStatus [
	^ GtNotificationNullStatus new
]

{ #category : #'load and saving' }
GtNotificationStatusRegistry >> instantiateStatusFrom: newsItemData [
	| statusValue |
	statusValue := newsItemData at: 'status' ifAbsent: [ ^ GtNotificationNullStatus new ].
	^ GtNotificationStatus 
		statusFor: statusValue ifNone: [ GtNotificationNullStatus new ]
]

{ #category : #accessing }
GtNotificationStatusRegistry >> markNotificationDismissedForId: anId [
	(self statusForId: anId) isDismissed ifTrue: [ ^ self ].
	
	statusesById 
		at: anId
		put: GtNotificationDismissedStatus new.
]

{ #category : #actions }
GtNotificationStatusRegistry >> markNotificationViewedForId: anId [
	(self statusForId: anId) isViewed ifTrue: [ ^ self ].
	
	statusesById 
		at: anId
		put: GtNotificationViewedStatus new.
]
