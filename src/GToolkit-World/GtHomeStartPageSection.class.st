"
I am a generic home section. By default, I will generate a home section card for the first table of contents page in the default database.
You can configure the title, the database name and the start page. For example:
```language=text
GtHomeStartPageSection new 
	title: 'YAML Parser';
	description: 'The YAML Parser project';
	databaseName: 'YAML Parser Notebook';
	startPageName: 'YAML Parser Overview'
```
To install the section, create an extension method of {{gtClass:name=GtHome}} , for example:
```language=text
GtHome >> yamlSection
	<gtHomeSection>
	^ GtHomeStartPageSection new 
		sectionTitle: 'Get started with the YAML Parser project';
		title: 'YAML Parser';
		description: 'The YAML Parser project';
		databaseName: 'YAML Parser Notebook';
		startPageName: 'YAML Parser Overview';
		priority: 8
```
Note that this should be categorized as an extension method of one of your packages, for example `*YAMLParser` (assuming `YAMLParser` is a package of your repo). In this way, as soon as your repo is loaded, so will the extension method, and your card will automatically appear in the home section.
"
Class {
	#name : #GtHomeStartPageSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'title',
		'description',
		'databaseName',
		'startPageName',
		'sectionTitle'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #accessing }
GtHomeStartPageSection >> card [
	^ self
		newHeaderCardWithTitle: self title
		description: self description
		size: 200 @ 150
		content: (BrLabel new
				text: self title;
				aptitude: BrGlamorousLabelAptitude new bold;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			GtWorldUtility
				showSpaceWithTitle: self startPage title
				inPagerWith: [ self startPage asLepiterPagePhlowTool asElementDo: [ :e | e ] ]
						asStencil
				from: card ]
]

{ #category : #accessing }
GtHomeStartPageSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: self sectionTitle).
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: self card.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #accessing }
GtHomeStartPageSection >> database [
	^ LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase
		databaseNamed: self databaseName
]

{ #category : #accessing }
GtHomeStartPageSection >> databaseName [
	databaseName ifNil: [ self databaseName: self defaultDatabaseName ].
	^ databaseName
]

{ #category : #accessing }
GtHomeStartPageSection >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
GtHomeStartPageSection >> defaultDatabaseName [
	^ 'Documents/lepiter/default'
]

{ #category : #accessing }
GtHomeStartPageSection >> defaultStartPage [
	^ self database tableOfContentsNodes first page
]

{ #category : #accessing }
GtHomeStartPageSection >> defaultStartPageName [
	^ self database tableOfContentsNodes first page title
]

{ #category : #accessing }
GtHomeStartPageSection >> defaultTitle [
	^ self startPage title
]

{ #category : #accessing }
GtHomeStartPageSection >> description [
	description ifNil: [ self description: self title ].
	^ description
]

{ #category : #accessing }
GtHomeStartPageSection >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtHomeStartPageSection >> sectionTitle [
	sectionTitle ifNil: [ self sectionTitle: self title ].
	^ sectionTitle
]

{ #category : #accessing }
GtHomeStartPageSection >> sectionTitle: anObject [
	sectionTitle := anObject
]

{ #category : #accessing }
GtHomeStartPageSection >> startPage [
	^ self database pageNamed: self startPageName
]

{ #category : #accessing }
GtHomeStartPageSection >> startPageName [
	startPageName ifNil: [ 
	self startPageName: self defaultStartPageName
	 ].
	^ startPageName
]

{ #category : #accessing }
GtHomeStartPageSection >> startPageName: aPageName [
	startPageName := aPageName
]

{ #category : #accessing }
GtHomeStartPageSection >> title [
	title ifNil: [ self title: self defaultTitle ].
	^ title
]

{ #category : #accessing }
GtHomeStartPageSection >> title: anObject [
	title := anObject
]
