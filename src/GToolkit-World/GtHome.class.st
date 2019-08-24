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
	self initializeCommunity
]

{ #category : #initialization }
GtHome >> initializeCommunity [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Community').
	
	aContainer := self newCardsContainer.
	aContainer addChild: (self newCard title: 'Spectrum'; description: '...').
	aContainer addChild: (self newCard title: 'Github'; description: '...').
	aContainer addChild: (self newCard title: 'Web'; description: '...').
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeDocumentation [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Documentation').
	
	aContainer := self newCardsContainer.
	aContainer addChild: (self newCard 
		title: 'Documentation'; 
		description: (('Documentation' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Start from the central point and inspect your way through the docs.' asRopedText fontSize: 14));
		picture: (((GtDocument new text: (BaselineOfGToolkit comment first: 500)) gtTextFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ])).
	
	aContainer addChild: (self newCard 
		title: 'Examples'; 
		description: (('Examples' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Examples are both tests and units of documentation.' asRopedText fontSize: 14));
		picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ])).
	aContainer addChild: (self newCard title: 'Tour'; 
		description: (('Tour' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Take an interative tour through the tools and engines.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('glamoroustoolkit' asRopedText 
				fontSize: 30; fontName: 'Helvetica Neue'; bold;
				in: [:title | (title from: 1 to: 'glamorous' size) thin];
				yourself)) asElement in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ])).
	aContainer addChild: (self newCard title: 'Pharo 101'; 
		description: (('Pharo 101' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('New to Pharo? Take an interactive tutorial.' asRopedText fontSize: 14));
		picture: ((GtTitleSlide new
			titleText: ('Pharo 101' asRopedText glamorousRegularFont
				fontSize: 30)) asElement in: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ])).
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeTools [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Tools').

	aContainer := self newCardsContainer.
	aContainer addChild: (self newCard
		title: 'Playground & Inspector';
		description: (('Playground & Inspector' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Script, inspect and code. Live.' asRopedText fontSize: 14));
		picture: ((GtPlayBook newDefault gtLiveFor: GtPhlowView empty) asElementDo: [:e | (e size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents ])).
	aContainer addChild: (self newCard
		title: 'Coder';
		description: (('Coder' asRopedText fontSize: 18) append: ((String cr, String cr) asRopedText); append: ('Browse, manipulate and organize code.' asRopedText fontSize: 14));
		picture: (((GtClassCoder forClass: GtClassCoder) asElement size: 300@300; asScalableElement) background: Color white; look: BrShadowLook; preventMeAndChildrenMouseEvents)).

	self addChild: aContainer
]

{ #category : #'instance creation' }
GtHome >> newCard [
	^ BrCard new
		look: (BrShadowLook new width: 6; color: (Color black alpha: 0.5)) + (BrDescriptionLook new readonly glamorousRegularFont foreground: Color black; descriptionDo: [:e | e margin: (BlInsets all: 10)]) + BrIconLook new;
		layout: (BlLinearLayout horizontal alignCenter cellSpacing: 0);
		geometry: (BlRectangle cornerRadius: 4);
		background: Color white;
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical exact: 150 ];
		padding: (BlInsets all: self spaceGap);
		margin: (BlInsets all: self spaceGap)
]

{ #category : #'instance creation' }
GtHome >> newCardsContainer [
	^ BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets top: self spaceGap left: (self spaceGap / 2.0) bottom: self spaceGap right: (self spaceGap / 2.0))
]

{ #category : #'instance creation' }
GtHome >> newHeaderLabel: aString [

	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; fontSize: 16);
		padding: (BlInsets left: (self spaceGap*2));
		margin: (BlInsets top: self spaceGap*2);
		text: aString
]

{ #category : #initialization }
GtHome >> spaceGap [
	^ 10
]
