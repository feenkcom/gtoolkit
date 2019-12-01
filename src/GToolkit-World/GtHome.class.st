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
	self addChild: GtHomeDocumentationSection new asElement
]

{ #category : #initialization }
GtHome >> initializeExternalLinks [
	^ GtHomeExternalLinksSection new asElement
]

{ #category : #initialization }
GtHome >> initializeTools [
	self addChild: GtHomeToolsSection new asElement
]

{ #category : #initialization }
GtHome >> spaceGap [
	^ 10
]
