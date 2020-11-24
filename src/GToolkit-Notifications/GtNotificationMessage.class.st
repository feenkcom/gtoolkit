Class {
	#name : #GtNotificationMessage,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'message'
	],
	#category : #'GToolkit-Notifications-Notifications'
}

{ #category : #'api - instance creation' }
GtNotificationMessage class >> message: aString [
	^ self new message: aString
]

{ #category : #'private - asserting' }
GtNotificationMessage >> assertMessage: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Notification message must be non-nil' ].
]

{ #category : #defaults }
GtNotificationMessage >> defaultMessage [
	^ ''
]

{ #category : #initialization }
GtNotificationMessage >> initialize [ 
	super initialize.
	message := self defaultMessage.
]

{ #category : #'api - accessing' }
GtNotificationMessage >> message [
	^ message
]

{ #category : #'api - accessing' }
GtNotificationMessage >> message: aString [
	self assertMessage: aString.
	message := aString.
]

{ #category : #printing }
GtNotificationMessage >> printOn: aStream [
	self message ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Notification: ';
		print: self message
]
