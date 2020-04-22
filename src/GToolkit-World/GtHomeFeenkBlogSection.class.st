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

{ #category : #private }
GtHomeFeenkBlogSection >> addChildren: aNewCards in: aCardsContainer [
	aCardsContainer enqueueTask: (BlTaskAction new action: [ aCardsContainer 
		removeChildren;
		addChildren: aNewCards ])
]

{ #category : #defaults }
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
	cardsContainer := self newCardsContainer.
	sectionContainer addChild: (self newSectionTitleWithUpdatesIn: cardsContainer).
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
GtHomeFeenkBlogSection >> newDocsExplorerWith: aCollectionOfPosts [
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
				with: (GtInspector createOn: (GtBlogPostList new posts: aCollectionOfPosts))
				from: card ]
]

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newExceptionLabelFor: anException [
	^ BrLabel new
		look: (BrGlamorousLabelLook new
			foreground: BrGlamorousColors linkWithErrorColor;
			fontSize: 14);
		padding: self newSectionTitlePaddingInsets;
		text: anException messageText
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
				with: (GtInspector withToolOn: aXdFileInfo asElement)
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
GtHomeFeenkBlogSection >> newSectionTitleWithUpdatesIn: aCardsContainer [
	| aLabel aButton aContainer |
	aLabel := self newSectionTitle: 'blog.feenk.com'.
	aButton := self newSectionButtonWithIcon: BrGlamorousVectorIcons refresh.
	aButton margin: (BlInsets left: 5).
	aButton label: 'Update blog feed'.
	aButton action: [ :card | self documentsInto: aCardsContainer ].
	aButton beSmall.
	aContainer := self newSectionTitleContainer.
	^ aContainer addChild: aLabel; addChild: aButton
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

{ #category : #'instance creation' }
GtHomeFeenkBlogSection >> newUpdateDocsContent [
	^ BrLabel new
		text: 'Update ...';
		look: BrGlamorousLabelLook;
		padding: (BlInsets all: 20)
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onFailure: anException in: aCardsContainer [
	| aCard |
	aCard := self newExceptionLabelFor: anException.
	self addChildren: { aCard } in: aCardsContainer.
]

{ #category : #hooks }
GtHomeFeenkBlogSection >> onPosts: aCollectionOfPosts in: aCardsContainer [
	| newCards |
	newCards := OrderedCollection 
		streamContents: [ :aStream |
			self newPostCardsFor: aCollectionOfPosts into: aStream ]
		limitedTo: 5.
	newCards := newCards asOrderedCollection.
	newCards add: (self newDocsExplorerWith: aCollectionOfPosts).
	self addChildren: newCards in: aCardsContainer.
]
