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
		c vertical matchParent ].
	
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
	aContainer addChild: (self newCard 
		title: 'Documentation'; 
		description: (('Documentation' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Start from the central point and inspect your way through the docs.' asRopedText fontSize: 14));
		picture: (((GtDocument new text: (BaselineOfGToolkit comment first: 500)) gtTextFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit)) from: card ]).
	
	aContainer addChild: (self newCard 
		title: 'Examples'; 
		description: (('Examples' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Examples are both tests and units of documentation.' asRopedText fontSize: 14));
		picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card |
			self showSpaceWithTitle: 'Documentation' with: (GtInspector createOn: (GtRlGToolkitExamplesExplorer buildForGToolkitProject)) from: card ]).
		
	aContainer addChild: (self newCard title: 'Tour'; 
		description: (('Tour' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Take an interative tour through the tools and engines.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('glamoroustoolkit' asRopedText 
				fontSize: 30; fontName: 'Helvetica Neue'; bold;
				in: [:title | (title from: 1 to: 'glamorous' size) thin];
				yourself)) asElement in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card |
			self showSpaceWithTitle: 'Tour' with: (GtTour new create) from: card ]).
				
	aContainer addChild: (self newCard title: 'Pharo 101'; 
		description: (('Pharo 101' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('New to Pharo? Take an interactive tutorial.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('Pharo 101' asRopedText glamorousRegularFont
				fontSize: 30)) asElement in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card |
			self showSpaceWithTitle: 'Pharo 101' with: (GtPharo101 new create) from: card ]).
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeExternalLinks [
	| aContainer |
	self addChild: (self newHeaderLabel: 'External links').
	
	aContainer := self newCardsContainer.
	
	aContainer addChild: (self newCard title: 'Web'; 
		description: (('Web' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('The official webpage.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('gtoolkit.com' asRopedText glamorousRegularFont fontSize: 20)) asElement 
				in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card | WebBrowser openOn: 'https://gtoolkit.com' ]).	

	aContainer addChild: (self newCard title: 'GitHub'; 
		description: (('GitHub' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Browse the code. Open issues. Engage.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('github.com/feenkcom/gtoolkit' asRopedText glamorousRegularFont fontSize: 20)) asElement 
				in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card | WebBrowser openOn: 'https://github.com/feenkcom/gtoolkit' ]).	
	
	aContainer addChild: (self newCard title: 'Spectrum'; 
		description: (('Community' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Join our online community to ask questions and have fun.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('spectrum.chat/gtoolkit' asRopedText glamorousRegularFont fontSize: 25)) asElement 
				in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card | WebBrowser openOn: 'https://spectrum.chat/gtoolkit' ]).	
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeTools [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Tools').

	aContainer := self newCardsContainer.
	aContainer addChild: (self newCard
		title: 'Playground';
		description: (('Playground' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Script, inspect and code. Live.' asRopedText fontSize: 14));
		picture: ((GtPlayBook newDefault gtLiveFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ]);
		action: [ :card |
			self showSpaceWithTitle: 'Playground' with: GtPlaygroundStencil new create from: card ]).
	aContainer addChild: (self newCard
		title: 'Coder';
		description: (('Coder' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Browse, manipulate and organize code.' asRopedText fontSize: 14));
		picture: (((GtClassCoder forClass: GtClassCoder) asElement size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents);
		action: [ :card |
			self showSpaceWithTitle: 'Coder' with: GtCoderStencil new create from: card ]).

	aContainer addChild: (self newCard
		title: 'Spotter';
		description: (('Spotter' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Search anything. Really anything.' asRopedText fontSize: 14));
		picture: ((GtSpotterSlide new create asElement size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents);
		action: [ :card | card fireEvent: GtSpawnSpotter new ]).

	self addChild: aContainer
]

{ #category : #'instance creation' }
GtHome >> newCard [
	^ BrCard new
		look: (BrShadowLook new width: 6; color: (Color black alpha: 0.5)) + (BrDescriptionLook new readonly glamorousRegularFont foreground: Color black; descriptionDo: [:e | e margin: (BlInsets all: 10)]) + BrIconLook new + BrGlamorousButtonExteriorLook new;
		layout: (BlLinearLayout horizontal alignCenter cellSpacing: 0);
		geometry: (BlRectangle cornerRadius: 4);
		background: Color white;
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical exact: 150 ];
		padding: (BlInsets all: self spaceGap);
		margin: (BlInsets top: self spaceGap left: self spaceGap*2 bottom: self spaceGap right: self spaceGap*2)
]

{ #category : #'instance creation' }
GtHome >> newCardsContainer [
	^ BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets top: self spaceGap*2 left: 0 bottom: self spaceGap*2 right: 0)
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
