Class {
	#name : #GtHomeFeed,
	#superclass : #BlElement,
	#category : #'GToolkit-World-UI'
}

{ #category : #initialization }
GtHomeFeed >> createSectionWrapperFor: aSectionStencil [
	^ BlLazyElement new
			margin: (BlInsets all: 10);
			layout: BlFrameLayout new;
			withGlamorousPreview;
			constraintsDo: [ :c |
				c vertical exact: 100.
				c horizontal matchParent ];
			postAction: [ :theLazyElement | theLazyElement constraintsDo: [ :c | 
				c vertical fitContent ] ];
			elementBuilder: [ aSectionStencil asElement ]
]

{ #category : #actions }
GtHomeFeed >> disableFeed [
	self feedSettings 
		markAsDisabled;
		saveContent.
	self hideFeed
]

{ #category : #actions }
GtHomeFeed >> enableFeed [
	self feedSettings 
		markAsEnabled;
		addFeenkBlog;
		saveContent.
	self showFeedSections
]

{ #category : #accessing }
GtHomeFeed >> feedSectionStencils [
	^ { self feenkBlogSection }
]

{ #category : #accessing }
GtHomeFeed >> feedSettings [
	^ GtFeed defaultInstance
]

{ #category : #'sections-feed' }
GtHomeFeed >> feenkBlogSection [
	^ GtHomeFeenkBlogSection newDefault
		priority: 18
]

{ #category : #initialization }
GtHomeFeed >> hideFeed [
	self removeChildren.
	self visibility: BlVisibility gone
]

{ #category : #initialization }
GtHomeFeed >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
]

{ #category : #initialization }
GtHomeFeed >> showFeedSections [
	| sections  |
	self removeChildren.
	sections := self feedSectionStencils collect: [ :eachStencil |
		self createSectionWrapperFor: eachStencil ].
	
	self addChild: (BrLabel new
		text: 'Feed';
		look: (BrGlamorousLabelLook new
			foreground: Color gray)).
	
	self addChildren: sections.
]

{ #category : #initialization }
GtHomeFeed >> showPermissionDialog [	
	| buttonsContainer dialogContainer |
	self removeChildren.
	
	dialogContainer := BrVerticalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 10);
		background: BrGlamorousColors newsBackgroundColor.
		
	"document := GtDocumenter forText: 'Would you like to get our posts from blog.feenk.com directly in your environment as executable documents?'.
	document 
		hMatchParent;
		vFitContent.
	dialogContainer addChild: document."

	dialogContainer addChild: (BrEditor new
		text: 'Would you like to get our posts from blog.feenk.com directly in your environment as executable documents?';
		look: BrGlamorousRegularEditorLook ).
	
	buttonsContainer := BrHorizontalPane new
		fitContent.
	buttonsContainer addChild: (BrButton new 
		label: 'Yes';
		look: BrGlamorousButtonWithLabelLook;
		margin: (BlInsets right: 10);
		action: [ self enableFeed ]).
	buttonsContainer addChild: (BrButton new 
		label: 'No';
		look: BrGlamorousButtonWithLabelLook;
		action: [ self disableFeed ]).
	dialogContainer addChild: buttonsContainer.
	self addChild: dialogContainer

]

{ #category : #updating }
GtHomeFeed >> updateWidget [
	self feedSettings isNotConfigured
		ifTrue: [ ^ self showPermissionDialog ].
	self feedSettings isEnabled 
		ifTrue: [ ^ self showFeedSections ].
	self hideFeed
]
