"
I am an ${class:BlElement}$.
I am an abstract class.
Muy subclasses implement user notification dialogs to request user credentials. Those credentials are used to login in to *GitHub>https://github.com* and similar Git repositories.
See my ${class:GtNotificationIcebergCredentialsElement|show=#gtSubclassesFor:|label=subclasses|expanded=true|height=150}$ for specific examples:

"
Class {
	#name : #GtNotificationIcebergCredentialsElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'inputsArea',
		'acceptButton',
		'borderElement',
		'headerElement'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'private - actions' }
GtNotificationIcebergCredentialsElement >> accept [
	"Accept dialog values"
	self storeCredentials.
	self closeDialog.
	self acceptCallbackDo: [ :aCallback | aCallback value ].
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> acceptButton [
	<return: #BrButton>
	^ acceptButton
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> acceptCallbackDo: aBlock [
	self notificationDo: [ :aNotification |
		aNotification acceptCallback ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #'private - actions' }
GtNotificationIcebergCredentialsElement >> cancel [
	"Cancel dialog values"
	self dismiss.
	self cancelCallbackDo: [ :aCallback | aCallback value ].
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> cancelCallbackDo: aBlock [
	self notificationDo: [ :aNotification |
		aNotification cancelCallback ifNotNil: aBlock ]
]

{ #category : #'private - actions' }
GtNotificationIcebergCredentialsElement >> closeDialog [
	self credentialStoreDo: [ :aStore |
		self credentialsDo: [ :aCredentials |
			self hostDo: [ :aHost |
				self dismiss ] ] ].
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> credentialStoreDo: aBlock [
	self notificationDo: [ :aNotification |
		aNotification credentialStore ifNotNil: aBlock ]
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> credentialsDo: aBlock [
	self notificationDo: [ :aNotification |
		aNotification credentials ifNotNil: aBlock ]
]

{ #category : #initialization }
GtNotificationIcebergCredentialsElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> headerElement [
	<return: #BrLabel>
	^ headerElement
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> hostDo: aBlock [
	self credentialsDo: [ :aCreedentials |
		aCreedentials host ifNotNil: aBlock ]
]

{ #category : #initialization }
GtNotificationIcebergCredentialsElement >> initialize [
	super initialize.
	self initializeHeaderElement.
	self initializeBorderElement.
	self initializeInputsArea.
	self initializeAcceptButton.

]

{ #category : #initialization }
GtNotificationIcebergCredentialsElement >> initializeAcceptButton [
	acceptButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		beSmall;
		icon: BrGlamorousVectorIcons accept;
		label: 'Accept';
		margin: (BlInsets top: 5 right: 10 bottom: 10 left: 10);
		action: [ self accept ].
]

{ #category : #initialization }
GtNotificationIcebergCredentialsElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
		borderDo: [ :anElement | 
			anElement 
				border: (BlBorder paint: BrGlamorousColors failureBackgroundColor width: 1);
				padding: (BlInsets all: 0) ];
		withCloseButtonAction: [ self cancel ]
]

{ #category : #initialization }
GtNotificationIcebergCredentialsElement >> initializeHeaderElement [
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
GtNotificationIcebergCredentialsElement >> initializeInputsArea [
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
	
]

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsElement >> inputsArea [
	<return: #GtNotificationElement>
	^ inputsArea
]

{ #category : #'private - instance creation' }
GtNotificationIcebergCredentialsElement >> newCommonInputField [
	^ BrEditor new
		text: '';
		padding: (BlInsets all: 3);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		hMatchParent;
		vFitContent.
]

{ #category : #'instance creation' }
GtNotificationIcebergCredentialsElement >> newHeaderTextForHost: aHost [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'private - instance creation' }
GtNotificationIcebergCredentialsElement >> newLabelWithText: aText [
	^ BrLabel new
		text: aText;
		look: (BrGlamorousLabelLook new
			glamorousRegularFont;
			glamorousRegularSmallSize);
		padding: (BlInsets top: 2 right: 3 bottom: 3 left: 3);
		fitContent
]

{ #category : #'private - instance creation' }
GtNotificationIcebergCredentialsElement >> newSecretInputField [ 
	^ self newCommonInputField
		look: (BrGlamorousRegularEditorLook new
			glamorousRegularFont;
			glamorousRegularSmallSize;
			replacingText: $*)
]

{ #category : #'private - instance creation' }
GtNotificationIcebergCredentialsElement >> newUserInput [
	^ self newCommonInputField
		look: (BrGlamorousRegularEditorLook new
			glamorousRegularFont;
			glamorousRegularSmallSize)
]

{ #category : #'private - hooks' }
GtNotificationIcebergCredentialsElement >> onNotificationChanged [
	super onNotificationChanged.
	self updateElement.
]

{ #category : #'private - actions' }
GtNotificationIcebergCredentialsElement >> storeCredentials [
	self subclassResponsibility
]

{ #category : #'private - updating' }
GtNotificationIcebergCredentialsElement >> updateElement [
	self hostDo: [ :aString |
		| aText |
		aText := self newHeaderTextForHost: aString.
		self headerElement text: aText. ].
]
