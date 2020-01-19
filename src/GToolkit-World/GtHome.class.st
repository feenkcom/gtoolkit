Class {
	#name : #GtHome,
	#superclass : #BlElement,
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
		c vertical fitContent ].
	
	self layout: (BlLinearLayout vertical cellSpacing: 2 * self spaceGap).
	self padding: (BlInsets all: self spaceGap).
	
	self initializeSections
]

{ #category : #initialization }
GtHome >> initializeSections [
	| homeSectionStencils |
	homeSectionStencils := self collectHomeSectionStencils.
	homeSectionStencils do: [ :aHomeSectionStencil |
		self addChild: aHomeSectionStencil asElement ]
]

{ #category : #initialization }
GtHome >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	SystemAnnouncer uniqueInstance weak
		when: (ClassAnnouncement where: [ :ann | ann classAffected = GtHome ])
		send: #update:
		to: self. 

	SystemAnnouncer uniqueInstance weak
		when: (MethodAnnouncement where: [ :ann | ann classAffected = GtHome ])
		send: #update:
		to: self. 
]

{ #category : #initialization }
GtHome >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	SystemAnnouncer uniqueInstance unsubscribe: self
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
	self removeChildren.
	self initializeSections
]
