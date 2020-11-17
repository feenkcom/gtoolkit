Class {
	#name : #GtNotificationIcebergCredentialsProvider,
	#superclass : #IceCredentialsProvider,
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'api - initialization' }
GtNotificationIcebergCredentialsProvider class >> beDefaultProvider [
	IceCredentialsProvider providerType: self
]

{ #category : #'private - testing' }
GtNotificationIcebergCredentialsProvider >> isFromBloc [
	^ BlParallelUniverse all
			detect: [ :eachUniverse |
				| aResult |
				aResult := false.
				eachUniverse hostClass
					uiProcessDo: [ :eachUIProcess |
						aResult := eachUIProcess = Processor activeProcess ].
				aResult ]
			ifFound: [ :aUniverse | true ]
			ifNone: [ false ].
]

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
	self obtainPlaintextCredentialsInBloc: credentialsToReturn.
]

{ #category : #private }
GtNotificationIcebergCredentialsProvider >> obtainPlaintextCredentialsForNonUIProcess: credentialsToReturn [
	
	| aCredentials aNotification aSemaphore isAccepted |
	isAccepted := false.
	aSemaphore := Semaphore new.
	aCredentials := IcePlaintextCredentials new.
	aCredentials host: remote host.
	aNotification := GtNotificationIcebergPlaintextCredentials new
		credentials: aCredentials;
		credentialStore: self credentialStore;
		acceptCallback: [ 
			isAccepted := true.
			aSemaphore signal ];
		cancelCallback: [ 
			isAccepted := false.
			aSemaphore signal ].
	GtWorld showNotification: aNotification.

	aSemaphore wait.

	isAccepted 
		ifTrue: [ credentialsToReturn readFrom: aCredentials ]
		ifFalse: [ LGitNoCredentialsProvided signal ].
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
