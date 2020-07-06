Class {
	#name : #GtInteractiveStatusRegistry,
	#superclass : #Object,
	#instVars : [
		'statusesById',
		'persistenceStrategy'
	],
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtInteractiveStatusRegistry class >> currentSchemaVersion [
	self subclassResponsibility
]

{ #category : #'instance creation' }
GtInteractiveStatusRegistry class >> loadDefault [
	^ self new
		persistenceStrategy: (GtLocalDataStorage 
			forFileWithBasename: self registryFileName
			withSchema: self currentSchemaVersion);
		loadContent
]

{ #category : #accessing }
GtInteractiveStatusRegistry class >> registryFileName [
	self subclassResponsibility
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> asDictionaryForExport [
	| statusesData |
	statusesData := OrderedCollection new.
	statusesById keysAndValuesDo: [ :id :status | 
		statusesData add: ({ 
			'id' -> id.
			'status' -> status registryValue asString
		 } asDictionary) ].
	^ {'statuses' -> statusesData asArray} asDictionary
]

{ #category : #accessing }
GtInteractiveStatusRegistry >> defaultStatus [
	self subclassResponsibility
]

{ #category : #ui }
GtInteractiveStatusRegistry >> gtViewStatusesFor: aView [
	<gtView>
	statusesById ifNil: [ ^ aView empty ].
	^ (statusesById gtItemsFor: aView)
		title: 'Statuses'
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> importDataFrom: aDictionary [
	(aDictionary at: 'statuses')
		select: [ :statusData | statusData includesKey: 'id' ]
		thenDo: [ :statusData | self loadStatusFromData: statusData ]
	
]

{ #category : #initialization }
GtInteractiveStatusRegistry >> initialize [
	super initialize.
	statusesById := OrderedDictionary new.
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> instantiateStatusFrom: newsItemData [
	| statusValue |
	statusValue := newsItemData at: 'status' ifAbsent: [ ^ self defaultStatus ].
	^ GtNotificationStatus 
		statusFor: statusValue ifNone: [ self defaultStatus ]
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> loadContent [
	self persistenceStrategy readContentAndDo: [ :rawData | 
		self importDataFrom: rawData ]
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> loadStatusFromData: newsItemData [ 
	| newsId newsStatus |
	newsId := newsItemData at: 'id'.
	newsStatus := self instantiateStatusFrom: newsItemData.
	statusesById 
		at: newsId
		put: newsStatus
]

{ #category : #accessing }
GtInteractiveStatusRegistry >> persistenceStrategy [
	^ persistenceStrategy
]

{ #category : #accessing }
GtInteractiveStatusRegistry >> persistenceStrategy: anObject [
	persistenceStrategy := anObject
]

{ #category : #'load and saving' }
GtInteractiveStatusRegistry >> saveContent [
	self persistenceStrategy saveObject: self
]

{ #category : #actions }
GtInteractiveStatusRegistry >> statusForId: anId [
	^ statusesById 
		at: anId
		ifAbsent: [ self defaultStatus ]
]
