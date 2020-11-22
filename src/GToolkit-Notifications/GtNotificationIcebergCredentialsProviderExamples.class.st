"
I exemplify ${class:GtNotificationIcebergCredentialsProvider}$, ${class:GtNotificationIcebergCredentialsElement}$, and ${class:GtNotificationIcebergCredentials}$.
"
Class {
	#name : #GtNotificationIcebergCredentialsProviderExamples,
	#superclass : #Object,
	#instVars : [
		'files'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> acceptEditedPlaintextCredentialsElement [
	<gtExample>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement usernameInputElement text: 'another username'.
	anElement passwordInputElement text: 'another password'.
	anElement accept.
	self assert: aStore allCredentials size equals: anExistingSize + 1.
	self assert: anElement notification credentials username equals: 'another username'.
	self assert: anElement notification credentials password equals: 'another password'.
	^ anElement
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> acceptPlaintextCredentialsElement [
	<gtExample>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement accept.
	self assert: aStore allCredentials size equals: anExistingSize + 1.
	^ anElement
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsProviderExamples >> addFile: aFile [
	self files add: aFile
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsProviderExamples >> basicCredentialStore [
	<gtExample>
	| aStore |
	aStore := IceCredentialStore new.
	self assert: (aStore instVarNamed: #storeFile) isNil.
	^ aStore
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> basicPlaintextCredentials [
	<gtExample>
	| aCredentials |
	aCredentials := IcePlaintextCredentials new.
	^ aCredentials
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> basicPlaintextCredentialsElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationIcebergPlaintextCredentialsElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsProviderExamples >> basicPlaintextCredentialsNotification [
	<gtExample>
	| aNotification |
	aNotification := GtNotificationIcebergPlaintextCredentials new.
	self assert: aNotification credentials isNotNil.
	self assert: aNotification credentialStore isNil.
	^ aNotification
]

{ #category : #'examples - provider' }
GtNotificationIcebergCredentialsProviderExamples >> basicProvider [
	<gtExample>
	| aProvider |
	aProvider := GtNotificationIcebergCredentialsProvider new.
	self assert: (aProvider instVarNamed: #remote) isNil.
	^ aProvider
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> basicSshCredentials [
	<gtExample>
	| aCredentials |
	aCredentials := IceSshCredentials new.
	^ aCredentials
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsProviderExamples >> basicSshCredentialsElement [
	<gtExample>
	| anElement |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsProviderExamples >> basicSshCredentialsNotification [
	<gtExample>
	| aNotification |
	aNotification := GtNotificationIcebergSshCredentials new.
	self assert: aNotification credentials isNotNil.
	self assert: aNotification credentialStore isNil.
	^ aNotification
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> cancelEditedPlaintextCredentialsElement [
	<gtExample>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement usernameInputElement text: 'another username'.
	anElement passwordInputElement text: 'another password'.
	anElement cancel.
	self assert: aStore allCredentials size equals: anExistingSize.
	self assert: anElement notification credentials username equals: self username.
	self assert: anElement notification credentials password equals: self password.
	^ anElement
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsProviderExamples >> credentialStore [
	<gtExample>
	| aStore aFile |
	aStore := self basicCredentialStore.
	aFile := self credentialStoreFile.
	aStore storeFile: aFile.
	self assert: (aStore instVarNamed: #storeFile) equals: aFile.
	^ aStore
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsProviderExamples >> credentialStoreFile [
	<gtExample>
	<after: #deleteFiles>
	| aFile |
	aFile := FileReference newTempFilePrefix: 'credentials.' suffix: '.fuel'.
	self addFile: aFile.
	self assert: aFile exists not.
	^ aFile
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> defaultSshCredentials [
	<gtExample>
	| aStore |
	aStore := self credentialStore.
	^ aStore defaultSSHCredential.
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsProviderExamples >> deleteFiles [
	files ifNotNil: [ :theFiles | 
		theFiles do: [ :eachFile | 
			eachFile ensureDelete ] ]
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsProviderExamples >> files [
	^ files ifNil: [ files := OrderedCollection new ]
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> host [
	^ 'github'
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> keyPassphrase [
	<gtExample>
	^ 'pass phrase'
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> password [
	<gtExample>
	^ 'mypassword'
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentials [
	<gtExample>
	| aCredentials |
	aCredentials := self basicPlaintextCredentials.
	aCredentials host: self host.
	self assert: aCredentials host equals: self host.
	^ aCredentials
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentialsElement [
	<gtExample>
	| anElement aNotification |
	anElement := GtNotificationIcebergPlaintextCredentialsElement new.
	aNotification := self plaintextCredentialsNotification.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self assert: anElement usernameInputElement text asString equals: aNotification credentials username.
	self assert: anElement passwordInputElement text asString equals: aNotification credentials password.
	^ anElement
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentialsElementWithUsernameAndPassword [
	<gtExample>
	| anElement aNotification |
	anElement := self basicPlaintextCredentialsElement.
	aNotification := self plaintextCredentialsNotificationWithUsernameAndPassword.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self assert: anElement usernameInputElement text asString equals: aNotification credentials username.
	self assert: anElement passwordInputElement text asString equals: aNotification credentials password.
	^ anElement
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentialsNotification [
	<gtExample>
	| aNotification aCredentials aStore |
	aNotification := self basicPlaintextCredentialsNotification.
	aCredentials := self plaintextCredentials.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentialsNotificationWithUsernameAndPassword [
	<gtExample>
	| aNotification aCredentials |
	aNotification := self plaintextCredentialsNotification.
	aCredentials := self plaintextCredentialsWithUsernameAndPassword.
	aNotification credentials: aCredentials.
	self assert: aNotification credentials equals: aCredentials.
	^ aNotification
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> plaintextCredentialsWithUsernameAndPassword [
	<gtExample>
	| aCredentials |
	aCredentials := self plaintextCredentials.
	aCredentials username: self username.
	aCredentials password: self password.
	self assert: aCredentials username equals: self username.
	self assert: aCredentials password equals: self password.
	^ aCredentials
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> privateKey [
	<gtExample>
	^ '/keys/my_private_key'
]

{ #category : #'examples - provider' }
GtNotificationIcebergCredentialsProviderExamples >> provider [
	<gtExample>
	| aProvider aRemote |
	aProvider := self basicProvider.
	aRemote := IceRemoteWithOnlyHostname for: 'example.com'.
	aProvider remote: aRemote.
	self assert: (aProvider instVarNamed: #remote) equals: aRemote.
	^ aProvider
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> publicKey [
	<gtExample>
	^ '/keys/my_public_key.pub'
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentials [
	<gtExample>
	| aCredentials |
	aCredentials := self basicSshCredentials.
	aCredentials host: self host.
	self assert: aCredentials host equals: self host.	
	^ aCredentials
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentialsElement [
	<gtExample>
	| anElement aNotification |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	aNotification := self sshCredentialsNotification.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self assert: anElement usernameInputElement text asString equals: aNotification credentials username.
	self assert: anElement publicKeyInputElement text asString equals: aNotification credentials publicKey.
	self assert: anElement privateKeyInputElement text asString equals: aNotification credentials privateKey.
	self assert: anElement keyPassphraseInputElement text asString equals: aNotification credentials keyPassphrase.
	^ anElement
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentialsElementWithKeys [
	<gtExample>
	| anElement aNotification |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	aNotification := self sshCredentialsNotificationWithKeys.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self assert: anElement usernameInputElement text asString equals: aNotification credentials username.
	self assert: anElement publicKeyInputElement text asString equals: aNotification credentials publicKey.
	self assert: anElement privateKeyInputElement text asString equals: aNotification credentials privateKey.
	self assert: anElement keyPassphraseInputElement text asString equals: aNotification credentials keyPassphrase.
	^ anElement
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentialsNotification [
	<gtExample>
	| aNotification aCredentials aStore |
	aNotification := self basicSshCredentialsNotification.
	aCredentials := self sshCredentials.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentialsNotificationWithKeys [
	<gtExample>
	| aNotification aCredentials aStore |
	aNotification := self basicSshCredentialsNotification.
	aCredentials := self sshCredentialsWithKeys.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsProviderExamples >> sshCredentialsWithKeys [
	<gtExample>
	| aCredentials |
	aCredentials := self sshCredentials.
	aCredentials username: self username.
	aCredentials publicKey: self publicKey.
	aCredentials privateKey: self privateKey.
	aCredentials keyPassphrase: self keyPassphrase.

	self assert: aCredentials username equals: self username.
	self assert: aCredentials publicKey equals: self publicKey.
	self assert: aCredentials privateKey equals: self privateKey.
	self assert: aCredentials keyPassphrase equals: self keyPassphrase.
	^ aCredentials
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsProviderExamples >> username [
	<gtExample>
	^ 'user'
]
