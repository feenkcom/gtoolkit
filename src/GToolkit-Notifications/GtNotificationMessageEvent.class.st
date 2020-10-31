Class {
	#name : #GtNotificationMessageEvent,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'message'
	],
	#category : #'GToolkit-Notifications-Events'
}

{ #category : #'api - instance creation' }
GtNotificationMessageEvent class >> message: aString [
	^ self new message: aString
]

{ #category : #'private - asserting' }
GtNotificationMessageEvent >> assertMessage: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Notification message must be non-nil' ].
]

{ #category : #defaults }
GtNotificationMessageEvent >> defaultMessage [
	^ ''
]

{ #category : #initialization }
GtNotificationMessageEvent >> initialize [ 
	super initialize.
	message := self defaultMessage.
]

{ #category : #'api - accessing' }
GtNotificationMessageEvent >> message [
	^ message
]

{ #category : #'api - accessing' }
GtNotificationMessageEvent >> message: aString [
	self assertMessage: aString.
	message := aString.
]

{ #category : #printing }
GtNotificationMessageEvent >> printOn: aStream [
	self message ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Notification: ';
		print: self message
]
