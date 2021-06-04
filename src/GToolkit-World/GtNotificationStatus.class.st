"
I model a status for a notifications. My subclasses provide concrete statuses. Curently only the ""viewed"" status is supported.
"
Class {
	#name : #GtNotificationStatus,
	#superclass : #Object,
	#traits : 'TGtInteractiveStatusInstantiation',
	#classTraits : 'TGtInteractiveStatusInstantiation classTrait',
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtNotificationStatus class >> registryValue [
	self subclassResponsibility
]

{ #category : #testing }
GtNotificationStatus >> isDismissed [
	^ false
]

{ #category : #testing }
GtNotificationStatus >> isViewed [
	^ false
]

{ #category : #accessing }
GtNotificationStatus >> registryValue [
	^ self class registryValue
]
