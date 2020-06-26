Class {
	#name : #GtHome,
	#superclass : #BlElement,
	#instVars : [
		'sectionsList'
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
GtHome >> createSectionsList [
	^ BrSimpleList new
		matchParent;
		items: #();
		stencil: [ :eachAssociation |
			eachAssociation value
				ifNil: [ eachAssociation value: (BlLazyElement new
					margin: (BlInsets all: self spaceGap);
					layout: BlFrameLayout new;
					withGlamorousPreview;
					constraintsDo: [ :c |
						c vertical exact: 100.
						c horizontal matchParent ];
					postAction: [ :theLazyElement | theLazyElement constraintsDo: [ :c | c vertical fitContent ] ];
					elementBuilder: [ eachAssociation key asElement ]) ]
				ifNotNil: [ eachAssociation value removeFromParent ].
			eachAssociation value ]
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

{ #category : #sections }
GtHome >> feenkBlogSection [
	"<gtHomeSection>"
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

{ #category : #accessing }
GtHome >> howToSection [
	<gtHomeSection>
	^ GtHomeHowToSection new
		priority: 19
]

{ #category : #initialization }
GtHome >> initialize [
	| contentHolder sectionsHolder newsHolder |
	super initialize.
	
	self background: Color white.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self padding: (BlInsets all: self spaceGap).
	self layout: BlLinearLayout vertical.
	
	contentHolder := BlElement new 
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	sectionsHolder := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c linear weight: 0.7.
			c horizontal matchParent.
			c vertical matchParent ].
	newsHolder := GtHomeNews new
		constraintsDo: [ :c |
			c linear weight: 0.3.
			c horizontal matchParent.
			c vertical matchParent ].
	
	sectionsList := self createSectionsList.
	sectionsHolder addChild: sectionsList.
	
	contentHolder addChild: sectionsHolder.
	newsHolder hasNewsItems ifTrue: [ 
		contentHolder addChild: newsHolder ].
	
	self addChild: contentHolder.
	self addChild: self createVersionLabel.
	
	self initializeSections
]

{ #category : #initialization }
GtHome >> initializeSections [
	sectionsList items: (self collectHomeSectionStencils collect: [ :eachStencil | eachStencil -> nil ])
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

{ #category : #initialization }
GtHome >> update: anAnnouncement [
	anAnnouncement classAffected == self class
		ifFalse: [ ^ self ].

	self initializeSections
]
