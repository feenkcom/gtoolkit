Class {
	#name : #GtHome,
	#superclass : #BlElement,
	#instVars : [
		'sectionsList'
	],
	#category : #'GToolkit-World'
}

{ #category : #initialization }
GtHome >> collectHomeSectionStencils [
	^ GtHomeSectionsCollector new
		fromObject: self;
		collect
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

{ #category : #initialization }
GtHome >> initialize [
	super initialize.
	
	self background: Color white.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self padding: (BlInsets all: self spaceGap).

	sectionsList := BrSimpleList new
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
			eachAssociation value ].

	self addChild: sectionsList.

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
		priority: 19
]

{ #category : #initialization }
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
	self initializeSections
]
