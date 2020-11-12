Class {
	#name : #GtNotificationIcebergCredentialsProvider,
	#superclass : #IceCredentialsProvider,
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'private - testing' }
GtNotificationIcebergCredentialsProvider >> isFromMorphic [
	| context worldMorphClass |
	worldMorphClass := Smalltalk 
		at: #WorldMorph
		ifAbsent: [ ^ false ].
	context := thisContext.
	[ context notNil ]
		whileTrue: [ (context receiver isKindOf: worldMorphClass)
				ifTrue: [ ^ true ].
			context := context sender ].
	^ false
]

{ #category : #private }
GtNotificationIcebergCredentialsProvider >> obtainPlaintextCredentials: credentialsToReturn [

	self isFromMorphic
		ifTrue: [ self obtainPlaintextCredentialsInMorphic: credentialsToReturn ] 
		ifFalse: [ self obtainPlaintextCredentialsInBloc: credentialsToReturn ]
]

{ #category : #private }
GtNotificationIcebergCredentialsProvider >> obtainPlaintextCredentialsInBloc: credentialsToReturn [
	
	| aCredentials aNotification |
	aCredentials := IcePlaintextCredentials new.
	aCredentials host: remote host.
	aNotification := GtNotificationIcebergPlaintextCredentials new 
		credentials: aCredentials;
		credentialStore: self credentialStore.
	GtWorld showNotification: aNotification.

	LGitNoCredentialsProvided signal.
]

{ #category : #private }
GtNotificationIcebergCredentialsProvider >> obtainPlaintextCredentialsInMorphic: credentialsToReturn [
	(IceTipInteractiveCredentialsProvider new 
		remote: remote)
			obtainPlaintextCredentials: credentialsToReturn.
]

{ #category : #private }
GtNotificationIcebergCredentialsProvider >> obtainSshCredentials: response [
	LGitNoCredentialsProvided signal.
]
