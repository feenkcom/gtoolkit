"
I am a ${class:GtNotificationEvent}$.
I am an abstract class.
Muy subclasses implement user notifications to request user credentials. Those credentials are used to login in to *GitHub>https://github.com* and similar Git repositories.
!! Common API
- ${method:GtNotificationIcebergCredentials>>#credentials|label=#selector}$,
- ${method:GtNotificationIcebergCredentials>>#credentialStore|label=#selector}$,
- ${method:GtNotificationIcebergCredentials>>#acceptCallback|label=#selector}$, and
- ${method:GtNotificationIcebergCredentials>>#cancelCallback|label=#selector}$.
!! Concrete Implementations
See my ${class:GtNotificationIcebergCredentials|show=#gtSubclassesFor:|label=subclasses|expanded=true|height=150}$ for specific examples:

"
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
	"Return a valuable object, e.g., block, that is evaluated by calling #value when a user provides (accepts) credentials"
	^ acceptCallback
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> acceptCallback: anObject [
	acceptCallback := anObject
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> cancelCallback [
	"Return a valuable object, e.g., block, that is evaluated by calling #value when a user cancels the credentials request"
	^ cancelCallback
]

{ #category : #accessing }
GtNotificationIcebergCredentials >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentialStore [
	"Return a store in which a user credentials can be stored"
	<return: #IceCredentialStore>
	^ credentialStore
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentialStore: aIceCredentialStore [
	credentialStore := aIceCredentialStore
]

{ #category : #'api - accessing' }
GtNotificationIcebergCredentials >> credentials [
	"Return credentials that are expected to be filled (initialiezd) by a user"
	<return: #IceAbstractCredentials>
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
