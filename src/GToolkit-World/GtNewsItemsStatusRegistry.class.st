"
I provide support for marking cards in the home screen as viewed.

I hold a list of status objects for cards and know how to persists it and read it from a STON preference file. For cards that are viewed I return a ${class:GtNewsItemViewedStatus}$. Otherwise if no status was saved for a card I return a status of type ${class:GtNewsItemNullStatus}$.
"
Class {
	#name : #GtNewsItemsStatusRegistry,
	#superclass : #Object,
	#instVars : [
		'registryFileLocator',
		'newsStatusesById'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemsStatusRegistry class >> defaultInstance [
	^ defaultInstance ifNil: [  
		self initializeDefaultVersion.
		defaultInstance ]
]

{ #category : #accessing }
GtNewsItemsStatusRegistry class >> defaultPreferences [
	^ FileLocator preferences / 'pharo'
]

{ #category : #'class initialization' }
GtNewsItemsStatusRegistry class >> initialize [
	SessionManager default
		register: (ClassSessionHandler forClassNamed: self name)
		inCategory: SessionManager default guiCategory  
		atPriority: SessionManager default defaultPriority
]

{ #category : #'system startup' }
GtNewsItemsStatusRegistry class >> initializeDefaultVersion [ 
	defaultInstance := self loadDefault
]

{ #category : #'instance creation' }
GtNewsItemsStatusRegistry class >> loadDefault [
	^ self new
		registryFileLocator: self defaultPreferences / self registryFileName;
		loadContent
]

{ #category : #accessing }
GtNewsItemsStatusRegistry class >> registryFileName [
	^ 'org.glamoroustoolkit.news-items-statuses.ston'
]

{ #category : #'system startup' }
GtNewsItemsStatusRegistry class >> startUp: resuming [
	resuming
		ifFalse: [ ^ self ]. 
	self initializeDefaultVersion.
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> createRegistryData [
	| registyData |
	registyData := OrderedCollection new.
	newsStatusesById keysAndValuesDo: [ :newsId :newsStatus | 
		registyData add: ( { 
			'id' -> newsId.
			'status' -> newsStatus registryValue
		 } asDictionary ) ]. 
	^ registyData asArray
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> createStatusFrom: newsItemData [
	| statusValue |
	statusValue := newsItemData at: 'status' ifAbsent: [ ^ GtNewsItemNullStatus new ].
	^ (statusValue = 'viewed') 
		ifTrue: [ GtNewsItemViewedStatus new ] 
		ifFalse: [ GtNewsItemNullStatus new ] 
]

{ #category : #ui }
GtNewsItemsStatusRegistry >> gtViewStatusesFor: aView [
	<gtView>
	newsStatusesById ifNil: [ ^ aView empty ].
	^ (newsStatusesById gtItemsFor: aView)
		title: 'Statuses'
]

{ #category : #initialization }
GtNewsItemsStatusRegistry >> initialize [
	super initialize.
	newsStatusesById := OrderedDictionary new.
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> loadContent [
	| fileReference registryData |
	fileReference := self registryFileReference.
	fileReference exists ifFalse: [ ^ self ].
	registryData := fileReference readStreamDo: [ :aReadStream |
		STON fromStream: aReadStream ].
	registryData
		select: [ :newsItemData | newsItemData includesKey: 'id' ]
		thenDo: [ :newsItemData | self loadNewsStatusFromData: newsItemData ]
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> loadNewsStatusFromData: newsItemData [ 
	| newsId newsStatus |
	newsId := newsItemData at: 'id'.
	newsStatus := self createStatusFrom: newsItemData.
	newsStatusesById 
		at: newsId
		put: newsStatus
]

{ #category : #actions }
GtNewsItemsStatusRegistry >> markNewsViewedForId: anId [
	(self statusForNewsId: anId) isViewed ifTrue: [ ^ self ].
	
	newsStatusesById 
		at: anId
		put: GtNewsItemViewedStatus new.
	self saveContent.
]

{ #category : #accessing }
GtNewsItemsStatusRegistry >> registryFileLocator [
	^ registryFileLocator
]

{ #category : #accessing }
GtNewsItemsStatusRegistry >> registryFileLocator: aFileLocator [
	registryFileLocator := aFileLocator
]

{ #category : #accessing }
GtNewsItemsStatusRegistry >> registryFileReference [
	^ self registryFileLocator asFileReference
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> saveContent [
	| fileReference |
	fileReference := self registryFileReference.
	fileReference ensureDelete.
	fileReference parent ensureCreateDirectory.
	fileReference writeStreamDo: [ :aPreferenceStream | 
		self 
			saveStonFor: self createRegistryData
			into: aPreferenceStream ]
]

{ #category : #'load and saving' }
GtNewsItemsStatusRegistry >> saveStonFor: aValue into: aWriteStream [
	STON 
		put: aValue 
		onStreamPretty: (ZnCharacterWriteStream on: aWriteStream encoding: 'utf8')
]

{ #category : #actions }
GtNewsItemsStatusRegistry >> statusForNewsId: anId [
	^ newsStatusesById 
		at: anId
		ifAbsent: [ GtNewsItemNullStatus new ]
]
