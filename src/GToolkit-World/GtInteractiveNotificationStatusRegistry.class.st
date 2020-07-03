Class {
	#name : #GtInteractiveNotificationStatusRegistry,
	#superclass : #Object,
	#instVars : [
		'statusesById',
		'persistenceStrategy'
	],
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtInteractiveNotificationStatusRegistry class >> currentSchemaVersion [
	self subclassResponsibility
]

{ #category : #'instance creation' }
GtInteractiveNotificationStatusRegistry class >> loadDefault [
	^ self new
		persistenceStrategy: (GtLocalDataStorage 
			forFileWithBasename: self registryFileName
			withSchema: self currentSchemaVersion);
		loadContent
]

{ #category : #accessing }
GtInteractiveNotificationStatusRegistry class >> registryFileName [
	self subclassResponsibility
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> asDictionaryForExport [
	| statusesData |
	statusesData := OrderedCollection new.
	statusesById keysAndValuesDo: [ :id :status | 
		statusesData add: ({ 
			'id' -> id.
			'status' -> status registryValue
		 } asDictionary) ].
	^ statusesData asArray
]

{ #category : #ui }
GtInteractiveNotificationStatusRegistry >> gtViewStatusesFor: aView [
	<gtView>
	statusesById ifNil: [ ^ aView empty ].
	^ (statusesById gtItemsFor: aView)
		title: 'Statuses'
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> importDataFrom: aDictionary [
	(aDictionary at: 'statuses')
		select: [ :statusData | statusData includesKey: 'id' ]
		thenDo: [ :statusData | self loadStatusFromData: statusData ]
	
]

{ #category : #initialization }
GtInteractiveNotificationStatusRegistry >> initialize [
	super initialize.
	statusesById := OrderedDictionary new.
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> instantiateStatusFrom: newsItemData [
	| statusValue |
	statusValue := newsItemData at: 'status' ifAbsent: [ ^ GtNewsItemNullStatus new ].
	^ (statusValue = GtNewsItemViewedStatus registryValue) 
		ifTrue: [ GtNewsItemViewedStatus new ] 
		ifFalse: [ GtNewsItemNullStatus new ] 
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> loadContent [
	self persistenceStrategy readContentAndDo: [ :rawData | 
		self importDataFrom: rawData ]
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> loadStatusFromData: newsItemData [ 
	| newsId newsStatus |
	newsId := newsItemData at: 'id'.
	newsStatus := self instantiateStatusFrom: newsItemData.
	statusesById 
		at: newsId
		put: newsStatus
]

{ #category : #actions }
GtInteractiveNotificationStatusRegistry >> markNewsViewedForId: anId [
	(self statusForId: anId) isViewed ifTrue: [ ^ self ].
	
	statusesById 
		at: anId
		put: GtNewsItemViewedStatus new.
]

{ #category : #accessing }
GtInteractiveNotificationStatusRegistry >> persistenceStrategy [
	^ persistenceStrategy
]

{ #category : #accessing }
GtInteractiveNotificationStatusRegistry >> persistenceStrategy: anObject [
	persistenceStrategy := anObject
]

{ #category : #'load and saving' }
GtInteractiveNotificationStatusRegistry >> saveContent [
	self persistenceStrategy saveObject: self
]

{ #category : #actions }
GtInteractiveNotificationStatusRegistry >> statusForId: anId [
	^ statusesById 
		at: anId
		ifAbsent: [ GtNewsItemNullStatus new ]
]
