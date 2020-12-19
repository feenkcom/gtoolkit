Class {
	#name : #GtHome,
	#superclass : #BlElement,
	#instVars : [
		'sectionsHolder',
		'feedElement',
		'notificationsElement'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtHome >> collectHomeSectionStencils [
	^ GtHomeSectionsCollector new
		fromObject: self;
		collect
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
	^ BrButton new 
		label: 'Glamorous Toolkit ', GtImage instance version versionString; 
		beSmallSize;
		look: (BrGlamorousButtonWithLabelLook new + (BrGlamorousButtonExteriorLook new borderPaint: Color transparent; backgroundPaint: Color transparent));
		margin: (BlInsets all: 5);
		constraintsDo: [ :c | c linear horizontal alignRight ];
		action: [ :button | 
			GtInspector 
				openOn: GtImage instance
				title: 'Glamorous Toolkit'
				from: button ]
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
	super initialize.
	
	self background: (Color r: 240 g: 240 b: 240 range: 255).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self layout: BlLinearLayout vertical.
	
	self initializePanes.
	self updateWidget
]

{ #category : #initialization }
GtHome >> initializePanes [
	| mainPane sectionsPane |
	notificationsElement := GtHomeNotifications new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	
	mainPane := BlElement new 
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets top: 0 left: 0 bottom: 0 right: self spaceGap).
	sectionsPane := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	feedElement := GtHomeFeed new.
	feedElement constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	
	sectionsHolder := self createSectionsHolder.
	sectionsPane addChild: notificationsElement.
	sectionsPane addChild: sectionsHolder.
	mainPane addChild: (self toolsSection create margin: (BlInsets top: 0 left: 0 bottom: self spaceGap * 2 right: self spaceGap * 2)).
	mainPane addChild: sectionsPane.
	mainPane addChild: feedElement.
	
	self addChild: (BrScrollPane new
		look: BrScrollPaneLook + BrGlamorousWithVerticalScrollbarLook;
		content: mainPane).
	self addChild: self createVersionLabel.
]

{ #category : #updating }
GtHome >> prepareForRelease [ 
	notificationsElement clearContent.
	feedElement clearContent
]

{ #category : #updating }
GtHome >> refreshNotifications [
	"Update the notifications and content of the home screen that can potentially changed 
	based on local user preferences."
	self updateNotifications.
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
"	<gtHomeSection>"
	^ GtHomeToolsSection new
		priority: 10
]

{ #category : #updating }
GtHome >> update: anAnnouncement [
	anAnnouncement classAffected == self class
		ifFalse: [ ^ self ].

	self updateWidget.
]

{ #category : #updating }
GtHome >> updateFeed [
	feedElement ifNotNil: [  
		feedElement updateWidget ]
]

{ #category : #updating }
GtHome >> updateNotifications [
	notificationsElement ifNotNil: [  
		notificationsElement updateWidget ]
]

{ #category : #updating }
GtHome >> updateSections [
	| sectionElements sectionStencils |
	sectionsHolder ifNil:  [ ^ self ].
	sectionsHolder removeChildren.
	sectionStencils := self collectHomeSectionStencils.
	sectionElements := sectionStencils collect: [ :eachStencil |
		self createSectionWrapperFor: eachStencil ].
	sectionsHolder addChildren: sectionElements.
]

{ #category : #updating }
GtHome >> updateWidget [
	self updateNotifications.
	self updateSections.
	self updateFeed.
]
