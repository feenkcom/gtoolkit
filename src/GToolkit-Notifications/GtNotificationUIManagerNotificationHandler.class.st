Class {
	#name : #GtNotificationUIManagerNotificationHandler,
	#superclass : #BlBlocUIManagerNotificationHandler,
	#category : #'GToolkit-Notifications-System Configuration'
}

{ #category : #'api - accessing' }
GtNotificationUIManagerNotificationHandler class >> priority [
	<return: #Number>
	"Higher number, higher priority"
	^ 5
]

{ #category : #enumerating }
GtNotificationUIManagerNotificationHandler >> elementDoOrSpaceDo: aBlock [
	GtNotificationForwarder spaceDo: aBlock
]
