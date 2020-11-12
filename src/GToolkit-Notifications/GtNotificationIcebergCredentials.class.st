Class {
	#name : #GtNotificationIcebergCredentials,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'credentials',
		'credentialStore'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentialStore [
	<return: #IceCredentialStore>
	^ credentialStore
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentialStore: aIceCredentialStore [
	credentialStore := aIceCredentialStore
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentials [
	^ credentials
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentials: anObject [
	credentials := anObject
]

{ #category : #defaults }
GtNotificationIcebergCredentials >> defaultCredentials [
	<return: #IceAbstractCredentials>
	^ self subclassResponsibility
]

{ #category : #initialization }
GtNotificationIcebergCredentials >> initialize [
	super initialize.
	credentials := self defaultCredentials.
]
