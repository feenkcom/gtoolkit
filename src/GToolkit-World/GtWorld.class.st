Class {
	#name : #GtWorld,
	#superclass : #BlSpace,
	#instVars : [
		'worldElement'
	],
	#classInstVars : [
		'defaultId'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #'instance creation' }
GtWorld class >> buildWithShutdownListener [
	| aSpace |
	aSpace := self new.
	aSpace title: self defaultTitle.
	aSpace extent: (800*1.6) @ 800.
	aSpace addShutdownListener.
	^ aSpace
]

{ #category : #accessing }
GtWorld class >> defaultId [
	^ defaultId
]

{ #category : #accessing }
GtWorld class >> defaultId: anId [
	"Set the id of the default space opened initially."
	defaultId := anId
]

{ #category : #defaults }
GtWorld class >> defaultTitle [
	^ 'Glamorous Toolkit'
]

{ #category : #'class initialization' }
GtWorld class >> initialize [
	"Register the handler to execute after the default priority that reads preferences."
	SessionManager default
		register: (ClassSessionHandler forClassNamed: self name)
		inCategory: SessionManager default guiCategory  
		atPriority: SessionManager default defaultPriority + 1
]

{ #category : #'class initialization' }
GtWorld class >> notifyDefaultInstance [
	self defaultId ifNil: [ ^ self ].
 	self
		spaceWithId: self defaultId 
		do: [ :aSpace | 
			aSpace enqueueTask: (BlTaskAction new action: [ 
				aSpace refreshContent ]) ] 
]

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := self new.
	aSpace title: self defaultTitle.
	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openDefault [
	"Open an instance with shutdown handlers and mark it as default."
	<script: 'self openDefault'>
	| aSpace |
	aSpace := self buildWithShutdownListener.
	aSpace markAsDefault.
	aSpace prepareForRelease.
	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openWithShutdownListener [
	<script: 'self openWithShutdownListener'>
	| aSpace |
	aSpace := self buildWithShutdownListener.
	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openWithSpaces: aCollectionOfSpaces [
	| aSpace |

	aSpace := self new.
	aSpace title: self defaultTitle.

	aCollectionOfSpaces do: [ :eachSpace |
		aSpace root showSpace: eachSpace ].

	aSpace show.
	^ aSpace
]

{ #category : #'instance creation' }
GtWorld class >> openWithSpaces: aCollectionOfSpaces from: aSpace [
	^ self openWithSpaces: aCollectionOfSpaces
]

{ #category : #'api - notification' }
GtWorld class >> showNotification: aNotification [
	BlSpace
		spaceWithId: self defaultId 
		do: [ :aSpace | 
			aSpace showNotification: aNotification ].
]

{ #category : #'class initialization' }
GtWorld class >> startUp: resuming [
	"Implement an update mechanism to update the saved world on open."
	resuming
		ifFalse: [ ^ self ]. 
	self notifyDefaultInstance.
]

{ #category : #accessing }
GtWorld >> addShutdownListener [
	self addEventHandler: BlSpaceShutdownOnCloseListener new
]

{ #category : #initialization }
GtWorld >> defaultTitle [
	^ self class defaultTitle
]

{ #category : #initialization }
GtWorld >> initialize [
	super initialize.
	
	worldElement := GtWorldElement new beInSeparateCompositionLayer.
	worldElement constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	
	self root addChild: worldElement.
"	self root addEventHandler: GtSceneDrillerEventHandler new"
]

{ #category : #actions }
GtWorld >> markAsDefault [
	"Mark this instance as being the one that is saved and automatically opened when
	the image is opened. This instance will refresh it's content on start-up."
	self class defaultId: self id
]

{ #category : #actions }
GtWorld >> prepareForRelease [
	"Prepare this space to be saved as part of the release process."
	worldElement prepareForRelease
]

{ #category : #actions }
GtWorld >> refreshContent [
	"Refresh the content of the space. Is only called for the default instance on start-up."
	worldElement refreshContent
]

{ #category : #accessing }
GtWorld >> removeShutdownListener [
	self removeEventHandlersSuchThat: [ :eachHandler | eachHandler isKindOf: BlSpaceShutdownOnCloseListener ]
]
