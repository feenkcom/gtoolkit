Class {
	#name : #GtHome,
	#superclass : #BlElement,
	#instVars : [
		'sectionsList',
		'sectionsHolder',
		'feedHolder'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtHome >> collectFeedSectionStencils [
	^ GtFeedSectionsCollector new
		fromObject: self;
		collect
]

{ #category : #accessing }
GtHome >> collectHomeSectionStencils [
	^ GtHomeSectionsCollector new
		fromObject: self;
		collect
]

{ #category : #building }
GtHome >> createFeedHolder [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent
]

{ #category : #building }
GtHome >> createSectionWrapperFor: aSectionStencil [
	^ BlLazyElement new
			margin: (BlInsets all: self spaceGap);
			layout: BlFrameLayout new;
			withGlamorousPreview;
			constraintsDo: [ :c |
				c vertical exact: 100.
				c horizontal matchParent ];
			postAction: [ :theLazyElement | theLazyElement constraintsDo: [ :c | 
				c vertical fitContent ] ];
			elementBuilder: [ aSectionStencil asElement ]
]

{ #category : #building }
GtHome >> createSectionsHolder [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent
]

{ #category : #building }
GtHome >> createVersionLabel [
	^ BrLabel new 
		text: 'Glamorous Toolkit ', GtImage instance version versionString; 
		look: (BrGlamorousLabelLook new 
			foreground: Color gray; 
			fontSize: 10);
		margin: (BlInsets right: 5);
		constraintsDo: [ :c | c linear horizontal alignRight ];
		padding: (BlInsets top: 0 left: 0 bottom: self spaceGap right: self spaceGap);
		when: BlClickEvent do: [ :e | 
			GtInspector 
				openOn: GtImage instance
				title: 'Glamorous Toolkit'
				from: e target ]
]

{ #category : #sections }
GtHome >> documentationSection [
	<gtHomeSection>
	^ GtHomeDocumentationSection new
		priority: 20
]

{ #category : #sections }
GtHome >> externalLinksSection [
	<gtHomeSection>
	^ GtHomeExternalLinksSection new
		priority: 30
]

{ #category : #feed }
GtHome >> feenkBlogSection [
	<gtFeedSection>
	^ GtHomeFeenkBlogSection newDefault
		priority: 18
]

{ #category : #ui }
GtHome >> gtViewHomeSectionsFor: aView [
	<gtView>
	^ aView list 
		title: 'Section Stencils';
		items: [ self collectHomeSectionStencils ]
]

{ #category : #sections }
GtHome >> howToSection [
	<gtHomeSection>
	^ GtHomeHowToSection new
		priority: 19
]

{ #category : #initialization }
GtHome >> initialize [
	| headerPane mainPane sectionsPane feedPane newsHolder |
	super initialize.
	
	self background: Color white.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self layout: BlLinearLayout vertical.
	
	headerPane := BlElement new 
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	newsHolder := GtHomeNews new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	
	mainPane := BlElement new 
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets top: self spaceGap left: 0 bottom: 0 right: self spaceGap).
	sectionsPane := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c linear weight: 0.7.
			c horizontal matchParent.
			c vertical fitContent ].
	feedPane := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c linear weight: 0.3.
			c horizontal matchParent.
			c vertical fitContent ].
	
	sectionsHolder := self createSectionsHolder.
	sectionsPane addChild: sectionsHolder.
	feedHolder := self createFeedHolder.
	feedPane addChild: feedHolder.
	
	mainPane addChild: sectionsPane.
	mainPane addChild: feedPane.
	
	newsHolder hasNewsItems ifTrue: [ 
		headerPane addChild: newsHolder ].
	
	self addChild: headerPane.
	self addChild: mainPane asScrollableElement.
	self addChild: self createVersionLabel.
	
	self updateSections.
	self updateFeed.
]

{ #category : #sections }
GtHome >> slideShowsSection [
	<gtHomeSection>
	^ GtHomeSlideShowsSection new
		priority: 15
]

{ #category : #accessing }
GtHome >> spaceGap [
	^ 10
]

{ #category : #sections }
GtHome >> toolsSection [
	<gtHomeSection>
	^ GtHomeToolsSection new
		priority: 10
]

{ #category : #updating }
GtHome >> update: anAnnouncement [
	anAnnouncement classAffected == self class
		ifFalse: [ ^ self ].

	self updateSections
]

{ #category : #updating }
GtHome >> updateFeed [
	| sections |
	feedHolder ifNil:  [ ^ self ].
	feedHolder removeChildren.
	sections := self collectFeedSectionStencils collect: [ :eachStencil |
		self createSectionWrapperFor: eachStencil ].
	feedHolder addChildren: sections.
]

{ #category : #updating }
GtHome >> updateSections [
	| sections |
	sectionsHolder ifNil:  [ ^ self ].
	sectionsHolder removeChildren.
	sections := self collectHomeSectionStencils collect: [ :eachStencil |
		self createSectionWrapperFor: eachStencil ].
	sectionsHolder addChildren: sections.
]
