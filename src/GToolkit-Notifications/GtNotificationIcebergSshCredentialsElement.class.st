"
I am an ${class:BlElement}$.
I implement user notification dialog to request ${class:IceSshCredentials|label=SSH}$ credentials from a user. Those credentials are used to login in to *GitHub>https://github.com* and similar Git repositories. When the user dialog is accepted, I store credentials to a ${class:IceCredentialStore}$.
!! Example 
${example:GtNotificationIcebergCredentialsExamples>>#sshCredentialsElementWithKeys|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtNotificationIcebergSshCredentialsElement,
	#superclass : #GtNotificationIcebergCredentialsElement,
	#instVars : [
		'usernameInputElement',
		'publicKeyInputElement',
		'privateKeyInputElement',
		'keyPassphraseInputElement'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #initialization }
GtNotificationIcebergSshCredentialsElement >> initialize [
	super initialize.
	
	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer alignCenterRight.
		aContainer addChild: self headerElement as: #label.
		aContainer addChild: self inputsArea as: #inputs.
		aContainer addChild: self acceptButton as: #accept
		 ].
	
	self addLook: (BrLayoutResizerLook new
			hInherit;
			vAnyToFitContent;
			hInherit: self headerElement;
			vAnyToFitContent: self headerElement;
			hInherit: self inputsArea;
			vAnyToFitContent: self inputsArea).
]

{ #category : #initialization }
GtNotificationIcebergSshCredentialsElement >> initializeInputsArea [
	| aLabel |
	super initializeInputsArea.
	
	aLabel := self newLabelWithText: 'Username:'.
	usernameInputElement := self newUserInput.
	inputsArea addChild: aLabel as: #usernameLabel.
	inputsArea addChild: usernameInputElement as: #usernameInput.

	aLabel := self newLabelWithText: 'Public key:'.
	publicKeyInputElement := self newUserInput.
	inputsArea addChild: aLabel as: #publicKeyLabel.
	inputsArea addChild: publicKeyInputElement as: #publicKeyInput.
	
	aLabel := self newLabelWithText: 'Private key:'.
	privateKeyInputElement := self newUserInput.
	inputsArea addChild: aLabel as: #privateKeyLabel.
	inputsArea addChild: privateKeyInputElement as: #privateKeyInput.
	
	aLabel := self newLabelWithText: 'Key passphrase:'.
	keyPassphraseInputElement := self newSecretInputField.
	inputsArea addChild: aLabel as: #passphraseLabel.
	inputsArea addChild: keyPassphraseInputElement as: #passphraseInput.
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> keyPassphraseDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials keyPassphrase ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> keyPassphraseInputElement [
	<return: #BrEditor>
	^ keyPassphraseInputElement
]

{ #category : #'private - instance creation' }
GtNotificationIcebergSshCredentialsElement >> newHeaderTextForHost: aHost [
	<return: #String>
	^ 'Please provide SSH keys to log in to ', aHost
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> privateKeyDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials privateKey ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> privateKeyInputElement [
	<return: #BrEditor>
	^ privateKeyInputElement
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> publicKeyDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials publicKey ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> publicKeyInputElement [
	<return: #BrEditor>
	^ publicKeyInputElement
]

{ #category : #'private - actions' }
GtNotificationIcebergSshCredentialsElement >> storeCredentials [
	self credentialStoreDo: [ :aStore |
		self credentialsDo: [ :aCredentials |
			self hostDo: [ :aHost | 
				aCredentials 
					username: self usernameInputElement text asString;
					publicKey: self publicKeyInputElement text asString;
					privateKey: self privateKeyInputElement text asString;
					keyPassphrase: self keyPassphraseInputElement text asString.
				aStore 
					storeCredential: aCredentials 
					forHostname: aHost. ] ] ].
]

{ #category : #'private - updating' }
GtNotificationIcebergSshCredentialsElement >> updateElement [
	super updateElement.
	self usernameDo: [ :aString |
		self usernameInputElement text: aString. ].
	self publicKeyDo: [ :aString |
		self publicKeyInputElement text: aString. ].
	self privateKeyDo: [ :aString |
		self privateKeyInputElement text: aString. ].
	self keyPassphraseDo: [ :aString |
		self keyPassphraseInputElement text: aString. ].
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> usernameDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials username ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergSshCredentialsElement >> usernameInputElement [
	<return: #BrEditor>
	^ usernameInputElement
]
