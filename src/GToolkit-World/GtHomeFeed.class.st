Class {
	#name : #GtHomeFeed,
	#superclass : #BlElement,
	#category : #'GToolkit-World-UI'
}

{ #category : #updating }
GtHomeFeed >> clearContent [
	self removeChildren.
	self visibility: BlVisibility gone
]

{ #category : #initialization }
GtHomeFeed >> createLinkAttribute [
	^ GtButtonAttribute new
		beAppend;
		stencil: [ BrButton new 
			look: BrGlamorousLinkSquaredButtonWithLabelLook new;
			beSmall;
			margin: (BlInsets top: -1 left: 0 bottom: 0 right: 0);
			label: 'blog.feenk.com';
			action: [ WebBrowser openOn: 'https://blog.feenk.com' ] ]
]

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
	self feed 
		markAsDisabled;
		saveContent.
	self hideFeed
]

{ #category : #actions }
GtHomeFeed >> enableFeed [
	self feed 
		markAsEnabled;
		addFeenkBlog;
		saveContent.
	self showFeedSections
]

{ #category : #accessing }
GtHomeFeed >> feed [
	^ GtFeed loadDefault
]

{ #category : #accessing }
GtHomeFeed >> feedSectionStencils [
	^ { self feenkBlogSection }
]

{ #category : #'sections-feed' }
GtHomeFeed >> feenkBlogSection [
	^ GtHomeFeenkBlogSection newDefault
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
		c vertical fitContent ]
]

{ #category : #initialization }
GtHomeFeed >> showFeedSections [
	| sections  |
	self removeChildren.
	self visibility: BlVisibility visible.
	
	sections := self feedSectionStencils collect: [ :eachStencil |
		self createSectionWrapperFor: eachStencil ].
	
	self addChildren: sections.
]

{ #category : #initialization }
GtHomeFeed >> showPermissionDialog [	
	| buttonsContainer dialogContainer |
	self removeChildren.
	self visibility: BlVisibility visible.
	
	dialogContainer := BrVerticalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 10);
		background: BrGlamorousColors newsBackgroundColor.

	dialogContainer addChild: (BrEditor new
		text: ('Would you like to get our posts from ' asRopedText attribute: self createLinkAttribute)
			, ' directly in your environment as executable documents?' asRopedText;
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
	| aFeed |
	aFeed := self feed.
	aFeed isNotConfigured
		ifTrue: [ ^ self showPermissionDialog ].
	aFeed isEnabled 
		ifTrue: [ ^ self showFeedSections ].
	self clearContent
]
