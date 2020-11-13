Class {
	#name : #GtNotificationIcebergCredentials,
	#superclass : #GtNotificationEvent,
	#instVars : [
		'credentials',
		'credentialStore',
		'acceptCallback',
		'cancelCallback'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #accessing }
GtNotificationIcebergCredentials >> acceptCallback [
	^ acceptCallback
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> acceptCallback: anObject [
	acceptCallback := anObject
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> cancelCallback [
	^ cancelCallback
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> cancelCallback: anObject [
	cancelCallback := anObject
]

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
	acceptCallback := [ "do nothing" ].
	cancelCallback := [ "do nothing" ].
]
