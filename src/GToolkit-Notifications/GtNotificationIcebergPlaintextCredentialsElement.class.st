"
I am an ${class:BlElement}$.
I implement user notification dialog to request ${class:IcePlaintextCredentials|label=plaintext}$ credentials from a user. Those credentials are used to login in to *GitHub>https://github.com* and similar Git repositories. When the user dialog is accepted, I store credentials to a ${class:IceCredentialStore}$.
!! Example 
${example:GtNotificationIcebergCredentialsProviderExamples>>#plaintextCredentialsElementWithUsernameAndPassword|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtNotificationIcebergPlaintextCredentialsElement,
	#superclass : #GtNotificationIcebergCredentialsElement,
	#instVars : [
		'usernameInputElement',
		'passwordInputElement'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initialize [
	super initialize.
	
	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer alignCenterRight.
		aContainer addChild: self headerElement as: #label.
		aContainer addChild: self inputsArea as: #inputs.
		aContainer addChild: self acceptButton as: #accept
		 ].

	self addLook: (BrLayoutResizerLook new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self headerElement;
		vAnyToFitContent: self headerElement;
		hInherit: self inputsArea;
		vAnyToFitContent: self inputsArea).
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initializeInputsArea [
	| aLabel |
	super initializeInputsArea.
	
	aLabel := self newLabelWithText: 'Username:'.
	usernameInputElement := self newUserInput.
	inputsArea addChild: aLabel as: #usernameLabel.
	inputsArea addChild: usernameInputElement as: #usernameInput.
	
	aLabel := self newLabelWithText: 'Password:'.
	passwordInputElement := self newSecretInputField.
	inputsArea addChild: aLabel as: #passwordLabel.
	inputsArea addChild: passwordInputElement as: #passwordInput.
]

{ #category : #'private - instance creation' }
GtNotificationIcebergPlaintextCredentialsElement >> newHeaderTextForHost: aHost [
	<return: #String>
	^ 'Please log in to ', aHost
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> passwordDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials password ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> passwordInputElement [
	<return: #BrEditor>
	^ passwordInputElement
]

{ #category : #'private - actions' }
GtNotificationIcebergPlaintextCredentialsElement >> storeCredentials [
	self credentialStoreDo: [ :aStore |
		self credentialsDo: [ :aCredentials |
			self hostDo: [ :aHost | 
				aCredentials 
					username: self usernameInputElement text asString;
					password: self passwordInputElement text asString.
				aStore 
					storeCredential: aCredentials 
					forHostname: aHost. ] ] ].
]

{ #category : #'private - updating' }
GtNotificationIcebergPlaintextCredentialsElement >> updateElement [
	super updateElement.
	self usernameDo: [ :aString |
		self usernameInputElement text: aString. ].
	self passwordDo: [ :aString |
		self passwordInputElement text: aString. ].
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> usernameDo: aBlock [
	self credentialsDo: [ :aCreedenttials |
		aCreedenttials username ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> usernameInputElement [
	<return: #BrEditor>
	^ usernameInputElement
]
