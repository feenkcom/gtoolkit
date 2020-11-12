Class {
	#name : #GtNotificationIcebergPlaintextCredentialsElement,
	#superclass : #GtNotificationIcebergCredentialsElement,
	#instVars : [
		'borderElement',
		'headerElement',
		'inputsArea',
		'usernameInputElement',
		'passwordInputElement',
		'acceptButton'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'private - actions' }
GtNotificationIcebergPlaintextCredentialsElement >> accept [
	"Accept dialog values"
	self storeCredentials.
	self closeDialog.
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> acceptButton [
	<return: #BrButton>
	^ acceptButton
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #'private - actions' }
GtNotificationIcebergPlaintextCredentialsElement >> cancel [
	"Accept dialog values"
	self dismiss
]

{ #category : #'private - actions' }
GtNotificationIcebergPlaintextCredentialsElement >> closeDialog [
	self credentialStoreDo: [ :aStore |
		self credentialsDo: [ :aCredentials |
			self hostDo: [ :aHost |
				self dismiss ] ] ].
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> headerElement [
	<return: #BrLabel>
	^ headerElement
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initialize [
	super initialize.
	self initializeBorderElement.
	self initializeHeaderElement.
	self initializeInputsArea.
	self initializeAcceptButton.
	
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
GtNotificationIcebergPlaintextCredentialsElement >> initializeAcceptButton [
	acceptButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		beSmall;
		icon: BrGlamorousVectorIcons accept;
		label: 'Accept';
		margin: (BlInsets top: 5 right: 10 bottom: 10 left: 10);
		action: [ self accept ].
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
		borderDo: [ :anElement | 
			anElement 
				border: (BlBorder paint: BrGlamorousColors failureBackgroundColor width: 1);
				padding: (BlInsets all: 0) ];
		withCloseButtonAction: [ self cancel ]
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initializeHeaderElement [
	headerElement := BrLabel new
		text: (self newHeaderTextForHost: '');
		look: (BrGlamorousLabelLook new
			glamorousRegularFont;
			glamorousRegularSmallSize);
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10);
		background: BrGlamorousColors failureBackgroundColor;
		hMatchParent;
		vFitContent.
]

{ #category : #initialization }
GtNotificationIcebergPlaintextCredentialsElement >> initializeInputsArea [
	| aLabel |
	inputsArea := GtNotificationElement new
		hMatchParent;
		vFitContent;
		layout: (BlGridLayout new 
			columnCount: 2; 
			cellSpacing: 2);
		constraintsDo: [ :c |
			c padding: (BlInsets top: 5 right: 8 bottom: 10 left: 8).
			c grid horizontal alignLeft.
			c grid vertical alignCenter ].
	
	aLabel := self newLabelWithText: 'Username:'.
	usernameInputElement := self newUserInput.
	inputsArea addChild: aLabel as: #usernameLabel.
	inputsArea addChild: usernameInputElement as: #usernameInput.
	
	aLabel := self newLabelWithText: 'Password:'.
	passwordInputElement := self newSecretInputField.
	inputsArea addChild: aLabel as: #passwordLabel.
	inputsArea addChild: passwordInputElement as: #passwordInput.
	
]

{ #category : #'private - accessing' }
GtNotificationIcebergPlaintextCredentialsElement >> inputsArea [
	<return: #GtNotificationElement>
	^ inputsArea
]

{ #category : #'private - instance creation' }
GtNotificationIcebergPlaintextCredentialsElement >> newHeaderTextForHost: aHost [
	<return: #String>
	^ 'Please log in to ', aHost
]

{ #category : #'private - instance creation' }
GtNotificationIcebergPlaintextCredentialsElement >> newLabelWithText: aText [
	^ BrLabel new
		text: aText;
		look: (BrGlamorousLabelLook new
			glamorousRegularFont;
			glamorousRegularSmallSize);
		fitContent
]

{ #category : #'private - instance creation' }
GtNotificationIcebergPlaintextCredentialsElement >> newSecretInputField [ 
	^ BrEditor new
		text: '';
		look: (BrGlamorousRegularEditorLook new
			glamorousRegularFont;
			glamorousRegularSmallSize;
			replacingText: $*);
		padding: (BlInsets all: 0);
		hMatchParent;
		vFitContent.
]

{ #category : #'private - instance creation' }
GtNotificationIcebergPlaintextCredentialsElement >> newUserInput [
	^ BrEditor new
		text: '';
		look: (BrGlamorousRegularEditorLook new
			glamorousRegularFont;
			glamorousRegularSmallSize);
		padding: (BlInsets all: 0);
		hMatchParent;
		vFitContent.
]

{ #category : #'private - hooks' }
GtNotificationIcebergPlaintextCredentialsElement >> onNotificationChanged [
	super onNotificationChanged.
	self updateElement.
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
				aStore 
					storeCredential: aCredentials 
					forHostname: aHost. ] ] ].
]

{ #category : #'private - updating' }
GtNotificationIcebergPlaintextCredentialsElement >> updateElement [
	self hostDo: [ :aString |
		| aText |
		aText := self newHeaderTextForHost: aString.
		self headerElement text: aText. ].
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
