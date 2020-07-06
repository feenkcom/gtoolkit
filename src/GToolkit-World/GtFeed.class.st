Class {
	#name : #GtFeed,
	#superclass : #Object,
	#instVars : [
		'status',
		'feedSources',
		'persistenceStrategy'
	],
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeed class >> currentSchemaVersion [
	^ 'v1'
]

{ #category : #'instance creation' }
GtFeed class >> loadDefault [
	^ self new
		persistenceStrategy: (GtLocalDataStorage 
			forFileWithBasename: self registryFileName
			withSchema: self currentSchemaVersion);
		loadContent
]

{ #category : #accessing }
GtFeed class >> registryFileName [
	^ 'com.glamoroustoolkit.feeds'
]

{ #category : #actions }
GtFeed >> addFeenkBlog [
	self addSourceUrl: 'https://blog.feenk.com'
]

{ #category : #actions }
GtFeed >> addSourceUrl: anUrl [
	feedSources add: (GtFeedSource new
		url: anUrl)
]

{ #category : #converting }
GtFeed >> asDictionaryForExport [
	^ { 
		'status' -> status registryValue asString.
		'sources' -> (feedSources asArray collect: [ :aFeedSource |
			{'url'  -> aFeedSource url} asDictionary ])
	} asDictionary
]

{ #category : #accessing }
GtFeed >> feedSources [
	^ feedSources
]

{ #category : #ui }
GtFeed >> gtViewExportJSONFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Export (JSON)';
		priority: 50;
		text: [ 
			STONJSON toStringPretty: (self persistenceStrategy exportDictionaryForObject: self) ]
]

{ #category : #ui }
GtFeed >> gtViewSourcesFor: aView [
	<gtView>
	^ aView list 
		title: 'Sources';
		items: [ self feedSources ]
]

{ #category : #'load and saving' }
GtFeed >> importDataFrom: rawData [
	self loadStatusFrom: rawData.
	self loadSourcesFrom: rawData.
	
]

{ #category : #initialization }
GtFeed >> initialize [
	super initialize.
	status := GtFeedNotConfiguredStatus new.
	feedSources := OrderedCollection new.
]

{ #category : #testing }
GtFeed >> isEnabled [
	^ status isEnabled
]

{ #category : #testing }
GtFeed >> isLoadedDataValidFor: aDictionary [
	^ true
]

{ #category : #testing }
GtFeed >> isNotConfigured [ 
	^ status isNotConfigured
]

{ #category : #'load and saving' }
GtFeed >> loadContent [
	self persistenceStrategy readContentAndDo: [ :rawData | 
		self importDataFrom: rawData ]
]

{ #category : #'load and saving' }
GtFeed >> loadSourcesFrom: rawData [
	| sourcesValue |
	sourcesValue := rawData at: 'sources' ifAbsent: [ ^ self ].
	sourcesValue do: [ :sourceRawData |
		sourceRawData at: 'url' ifPresent: [ :anUrl |
			self addSourceUrl: anUrl ] ]
]

{ #category : #'load and saving' }
GtFeed >> loadStatusFrom: rawData [
	| statusValue |
	statusValue := rawData at: 'status' ifAbsent: [ ^ self ].
	status := GtFeedStatus 
		statusFor: statusValue 
		ifNone: [ GtFeedNotConfiguredStatus new ].
]

{ #category : #actions }
GtFeed >> markAsDisabled [
	status := GtFeedDisabledStatus new
]

{ #category : #actions }
GtFeed >> markAsEnabled [
	status := GtFeedEnabledStatus new
]

{ #category : #accessing }
GtFeed >> persistenceStrategy [
	^ persistenceStrategy
]

{ #category : #accessing }
GtFeed >> persistenceStrategy: anObject [
	persistenceStrategy := anObject
]

{ #category : #'load and saving' }
GtFeed >> saveContent [
	self persistenceStrategy saveObject: self
]
