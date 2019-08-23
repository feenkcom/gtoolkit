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
	aContainer addChild: (self newCard title: 'GT Tour'; description: '...').
	aContainer addChild: (self newCard title: 'Pharo 101'; description: '...').
	aContainer addChild: (self newCard title: 'Examples'; description: '...').
	
	self addChild: aContainer
]

{ #category : #initialization }
GtHome >> initializeTools [
	| aContainer |
	self addChild: (self newHeaderLabel: 'Tools').
	
	aContainer := self newCardsContainer.
	aContainer addChild: (self newCard title: 'Playground'; description: 'for scripting').
	aContainer addChild: (self newCard title: 'Coder'; description: 'for coding').
	aContainer addChild: (self newCard title: 'Transcript'; description: 'for logging').
	
	self addChild: aContainer
]

{ #category : #'instance creation' }
GtHome >> newCard [
	^ BrCard new
		look: BrGlamorousButtonExteriorLook + (BrGlamorousTextLabelLook new fontSize: 18) + (BrDescriptionLook new fitContent readonly glamorousRegularFont foreground: Color gray; fontSize: 16);
		background: Color white;
		layout: (BlLinearLayout vertical alignCenter cellSpacing: 0);
		geometry: (BlRectangle cornerRadius: 4);
		constraintsDo: [ :c |
			c horizontal exact: 140.
			c vertical exact: 70 ];
		padding: (BlInsets top: 0 left: (self spaceGap / 4.0 * 3.0) bottom: (self spaceGap / 4.0) right: (self spaceGap / 4.0 * 3.0));
		margin: (BlInsets right: self spaceGap * 1.5)
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
		look: (BrGlamorousLabelLook new fontSize: 24);
		padding: (BlInsets left: (self spaceGap / 2.0));
		margin: (BlInsets top: self spaceGap);
		text: aString
]

{ #category : #initialization }
GtHome >> spaceGap [
	^ 20
]
