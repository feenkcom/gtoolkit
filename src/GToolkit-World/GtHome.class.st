Class {
	#name : #GtHome,
	#superclass : #BlElement,
	#category : #'GToolkit-World'
}

{ #category : #initialization }
GtHome >> initialize [
	super initialize.
	
	self background: Color white.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	self layout: BlLinearLayout vertical.
	self padding: (BlInsets all: self spaceGap).
	
	self initializeTools.
	self initializeDocumentation.
	self initializeExternalLinks
]

{ #category : #initialization }
GtHome >> initializeDocumentation [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Documentation').
	
	aContainer := self newCardsContainer.
	aContainer addChild: (self 
		newCardWithTitle: 'Documentation' 
		description: 'Start from the central point and inspect your way through the docs.'
		picture: (((GtDocument new text: (BaselineOfGToolkit comment first: 500)) gtTextFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit)) from: card ]).
	
	aContainer addChild: (self 
		newCardWithTitle: 'Examples'
		description: 'Examples are both tests and units of documentation.'
		picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOn: (GtRlGToolkitExamplesExplorer buildForGToolkitProject)) from: card ]).
		
	aContainer addChild: (self 
		newCardWithTitle: 'Tour'
		description: 'Take an interative tour through the tools and engines.'
		picture: (GtTitleSlide new
			titleText: ('glamoroustoolkit' asRopedText 
				fontSize: 30; fontName: 'Helvetica Neue'; bold;
				in: [:title | (title from: 1 to: 'glamorous' size) thin];
				yourself))
		action: [ :card |self showSpaceWithTitle: 'Tour' with: (GtTour new create makeArrowsVisible) from: card ]).

	aContainer addChild: (self 
		newCardWithTitle:'One rendering tree' 
		description: 'All rendering relies on a single tree at a time.'
		picture: (GtTitleSlide new
			titleText: ('One rendering tree' asRopedText glamorousRegularFont
				fontSize: 30))
		action: [ :card | self showSpaceWithTitle: 'One rendering tree' with: (GtOneRenderingTree new create) from: card ]).

	aContainer addChild: (self 
		newCardWithTitle:'Pharo 101' 
		description: 'New to Pharo? Take an introductory tutorial.'
		picture: (GtTitleSlide new
			titleText: ('Pharo 101' asRopedText glamorousRegularFont
				fontSize: 30))
		action: [ :card | self showSpaceWithTitle: 'Pharo 101' with: (GtPharo101 new create makeArrowsVisible) from: card ]).
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeExternalLinks [
	| aContainer |
	self addChild: (self newHeaderLabel: 'External links').
	
	aContainer := self newCardsContainer.
	
	aContainer addChild: (self 
		newCardWithTitle: 'Web' 
		description: 'The official webpage.'
		picture: (GtTitleSlide new
			titleText: ('gtoolkit.com' asRopedText glamorousRegularFont fontSize: 20))
		action: [ :card | WebBrowser openOn: 'https://gtoolkit.com' ]).	

	aContainer addChild: (self 
		newCardWithTitle: 'GitHub'
		description: 'Browse the code. Open issues. Engage.'
		picture: (GtTitleSlide new
			titleText: ('github.com/feenkcom/gtoolkit' asRopedText glamorousRegularFont fontSize: 20))
		action: [ :card | WebBrowser openOn: 'https://github.com/feenkcom/gtoolkit' ]).	
	
	aContainer addChild: (self 
		newCardWithTitle: 'Community' 
		description: 'Join our online community to ask questions and have fun.'
		picture: (GtTitleSlide new
			titleText: ('spectrum.chat/gtoolkit' asRopedText glamorousRegularFont fontSize: 25))
		action: [ :card | WebBrowser openOn: 'https://spectrum.chat/gtoolkit' ]).	
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeTools [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Tools').

	aContainer := self newCardsContainer.
	aContainer addChild: (self 
		newCardWithTitle: 'Playground' 
		description: 'Script, inspect and code. Live.'
		picture: ((GtPlayBook newDefault gtLiveFor: GtPhlowView empty) asElementDo: [:e | e ])
		action: [ :card | self showSpaceWithTitle: 'Playground' with: GtPlaygroundStencil new create from: card ]).
	
	aContainer addChild: (self 
		newCardWithTitle: 'Coder'
		description: 'Browse, manipulate and organize code.'
		picture: (GtClassCoder forClass: GtClassCoder)
		action: [ :card | 	self showSpaceWithTitle: 'Coder' with: GtCoderStencil new create from: card ]).

	aContainer addChild: (self 
		newCardWithTitle: 'Spotter'
		description: 'Search anything. Really anything.'
		picture: GtSpotterSlide new create
		action: [ :card | card fireEvent: GtSpawnSpotter new ]).

	self addChild: aContainer
]

{ #category : #'instance creation' }
GtHome >> newCard [
	^ BrCard new
		look: (BrShadowLook new) +
			(BrDescriptionLook new readonly glamorousRegularFont descriptionDo: [:e | e padding: (BlInsets all: 10)]) +
			BrIconLook new +
			(BrGlamorousButtonExteriorLook new backgroundPaint: BrGlamorousColors secondaryHeaderBackgroundColor);
		layout: (BlLinearLayout horizontal alignCenter cellSpacing: 0);
		geometry: (BlRectangle cornerRadius: 4);
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical exact: 150 ];
		margin: (BlInsets top: self spaceGap * 2 left: self spaceGap * 2 bottom: self spaceGap * 2 right: self spaceGap * 2)
]

{ #category : #initialization }
GtHome >> newCardWithTitle: aTitle description: aDescription picture: anElementOrStencil action: aBlock [ 	
	^ self newCard
		title: aTitle;
		description: ((aTitle asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: (aDescription asRopedText "foreground: Color gray; "fontSize: 14));
		picture: (BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout new;
			addChild: (anElementOrStencil asElement background: Color white; size: 300@300; asScalableElement);
			margin: (BlInsets all: 1);
"			border: (BlBorder paint: BrGlamorousColors defaultButtonBorderColor); "
			preventMeAndChildrenMouseEvents);
		action: aBlock
]

{ #category : #'instance creation' }
GtHome >> newCardsContainer [
	^ BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets all: 0)
]

{ #category : #'instance creation' }
GtHome >> newHeaderLabel: aString [

	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; fontSize: 16);
		padding: (BlInsets left: (self spaceGap*2));
		margin: (BlInsets top: self spaceGap*2 bottom: 0);
		text: aString
]

{ #category : #initialization }
GtHome >> showSpaceWithTitle: aString with: anElement from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace addChild: anElement asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace
]

{ #category : #initialization }
GtHome >> spaceGap [
	^ 10
]
