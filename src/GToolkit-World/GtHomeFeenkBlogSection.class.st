Class {
	#name : #GtHomeFeenkBlogSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'client'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #defaults }
GtHomeFeenkBlogSection class >> defaultClient [
	^ XdClient new
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection class >> newDefault [
	^ self new 
		client: self defaultClient
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> cardSize [
	^ 150 @ 200
]

{ #category : #accessing }
GtHomeFeenkBlogSection >> client [
	^ client
]

{ #category : #accessing }
GtHomeFeenkBlogSection >> client: anObject [
	client := anObject
]

{ #category : #'api - instantiation' }
GtHomeFeenkBlogSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Feenk Blog').
	cardsContainer := self newCardsContainer.
	self documentsInto: cardsContainer.
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #defaults }
GtHomeFeenkBlogSection >> defaultClient [
	^ XdClient null
]

{ #category : #blog }
GtHomeFeenkBlogSection >> documentsInto: aCardsContainer [
	self client async 
		onSuccessDo: [ :aResult | self onPosts: aResult in: aCardsContainer ];
		onFailureDo: [ :anException | self onFailure: anException in: aCardsContainer ];
		documents
]

{ #category : #initialization }
GtHomeFeenkBlogSection >> initialize [
	super initialize.
	client := self defaultClient.
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newDocsExplorer [
	^ self
		newHeaderCardWithTitle: 'Post'
		description: 'Browse all feenk blog posts.'
		size: self cardSize
		content:
			(BrLabel new
				text: 'More posts ...';
				look: BrGlamorousLabelLook;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			self
				showSpaceWithTitle: 'Feenk Blog'
				with:
					(GtInspector
						createOn: GtRlGToolkitDocumentationExplorer buildForGToolkitProject)
				from: card ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardContentFor: aXdFileInfo [
	^ BrEditor new 
		look: BrGlamorousRegularEditorLook;
		beReadOnlyWithoutSelection;
		text: (self newTextFor: aXdFileInfo)
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardFor: aXdFileInfo [
	^ self 
		newHeaderCardWithTitle: 'Post'
		description: aXdFileInfo title
		size: self cardSize 
		content: (self newPostCardContentFor: aXdFileInfo) 
		action: [ :aCard | 
			self
				showSpaceWithTitle: aXdFileInfo title
				with: aXdFileInfo asElement
				from: aCard ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newPostCardsFor: aCollectionOfPosts into: aStream [
	aCollectionOfPosts do: [ :eachXdFileInfo | 
		| anElement |
		anElement := self newPostCardFor: eachXdFileInfo.
		aStream nextPut: anElement ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newTextFor: aXdFileInfo [

	| aTitle aDescription aText |
	aTitle := aXdFileInfo title asString asRopedText.
	aTitle bold.
	aDescription := aXdFileInfo description asString asRopedText.
	aText := aTitle append: (String cr, String cr) asRopedText.
	aText := aTitle append: aDescription.
	^ aText
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onFailure: anException in: aCardsContainer [
	anException inspect
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onPosts: aCollectionOfPosts in: aCardsContainer [
	| newCards |
	aCollectionOfPosts inspect.
	newCards := OrderedCollection 
		streamContents: [ :aStream |
			self newPostCardsFor: aCollectionOfPosts into: aStream ]
		limitedTo: 5.
	aCardsContainer enqueueTask: (BlTaskAction new action: [ aCardsContainer 
		removeChildren;
		addChildren: newCards;
		addChild: self newDocsExplorer ])
]
