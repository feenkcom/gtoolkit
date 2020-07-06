Class {
	#name : #GtLocalDataStorage,
	#superclass : #Object,
	#instVars : [
		'schemaVersion',
		'fileBaseName',
		'storageFolderLocator'
	],
	#category : #'GToolkit-World-Storage'
}

{ #category : #accessing }
GtLocalDataStorage class >> defaultPreferences [
	^ FileLocator preferences / 'pharo'
]

{ #category : #'instance creation' }
GtLocalDataStorage class >> forFileWithBasename: aFileName withSchema: schemaVersion [
	^ self new
		fileBaseName: aFileName;
		schemaVersion: schemaVersion;
		storageFolderLocator: self defaultPreferences
]

{ #category : #accessing }
GtLocalDataStorage >> exportDictionaryForObject: anObject [
	^ { 
		'schema' -> self schemaVersion.
		'data' -> anObject asDictionaryForExport 
	} asDictionary
]

{ #category : #accessing }
GtLocalDataStorage >> fileBaseName [
	^ fileBaseName
]

{ #category : #accessing }
GtLocalDataStorage >> fileBaseName: anObject [
	fileBaseName := anObject
]

{ #category : #accessing }
GtLocalDataStorage >> fileName [
	^ String streamContents: [ :aStream|
		aStream 
			nextPutAll: self fileBaseName;
			nextPutAll: '.';
			nextPutAll: self schemaVersion;
			nextPutAll: '.ston' ]
]

{ #category : #printing }
GtLocalDataStorage >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: self schemaVersion;
		nextPutAll: ', ';
		nextPutAll: self fileBaseName;
		nextPutAll: ')'
]

{ #category : #ui }
GtLocalDataStorage >> gtViewDetailsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Details';
		items: [ { 
			'Version' -> self schemaVersion.
			'Basename' -> self fileBaseName.
			'File name' -> self fileName } ];
		column: 'Name' item: #key;
		column: 'Value' item: #value
]

{ #category : #ui }
GtLocalDataStorage >> gtViewStorageFileFor: aView [
	<gtView>
	self storageFileReference exists	ifFalse: [ ^ aView empty ].
	^ self storageFileReference gtContentsFor: aView
]

{ #category : #ui }
GtLocalDataStorage >> gtViewStorageFolderFor: aView [
	<gtView>
	self storageFolderLocator ifNil: [ ^ aView empty ].
	^ (self storageFolderLocator asFileReference gtItemsFor: aView)
		title: 'Storage folder'
]

{ #category : #testing }
GtLocalDataStorage >> isRawDataValidFor: aDictionary [
	^ (aDictionary includesKey: 'data') and: [  
		 	(aDictionary at: 'schema' ifAbsent: [nil]) = self schemaVersion ]
]

{ #category : #actions }
GtLocalDataStorage >> readContentAndDo: aBlock [
	| fileReference rawData |
	fileReference := self storageFileReference.
	fileReference exists ifFalse: [ ^ self ].
	rawData := fileReference readStreamDo: [ :aReadStream |
		STONJSON fromStream: aReadStream ].
	
	(self isRawDataValidFor: rawData) ifTrue: [
		 aBlock value: (rawData at: 'data') ]
]

{ #category : #'load and saving' }
GtLocalDataStorage >> saveJsonFor: aValue into: aWriteStream [
	STONJSON
		put: aValue 
		onStreamPretty: (ZnCharacterWriteStream on: aWriteStream encoding: 'utf8')
]

{ #category : #actions }
GtLocalDataStorage >> saveObject: anObject [
	| fileReference |
	fileReference := self storageFileReference.
	fileReference ensureDelete.
	fileReference parent ensureCreateDirectory.
	fileReference writeStreamDo: [ :aPreferenceStream | 
		self 
			saveJsonFor: (self exportDictionaryForObject: anObject)
			into: aPreferenceStream ]
]

{ #category : #accessing }
GtLocalDataStorage >> schemaVersion [
	^ schemaVersion
]

{ #category : #accessing }
GtLocalDataStorage >> schemaVersion: anObject [
	schemaVersion := anObject
]

{ #category : #accessing }
GtLocalDataStorage >> storageFileReference [
	^ (self storageFolderLocator / self fileName) asFileReference
]

{ #category : #accessing }
GtLocalDataStorage >> storageFolderLocator [
	^ storageFolderLocator
]

{ #category : #accessing }
GtLocalDataStorage >> storageFolderLocator: anObject [
	storageFolderLocator := anObject
]
