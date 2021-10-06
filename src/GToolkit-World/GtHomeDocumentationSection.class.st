Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : 'GToolkit-World-Sections'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Docs').
	cardsContainer := self newCardsContainer.
	
	"cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkit).
	cardsContainer addChild: (self newDocCardForClass: GtAndPharoExplanation).
	cardsContainer addChild: (self newDocCardForClass: GtMoldableDevelopmentExplanation).
	cardsContainer addChild: (self newDocCardForClass: GtWhatMakesBlocSpecialExplanation).
	cardsContainer addChild: (self newDocCardForFile: (GtResourceReference path: Path * 'feenkcom' / 'gtoolkit-examples' / 'doc' / 'tutorial' / 'examples-tutorial.pillar')).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfBrick)."
	
	cardsContainer addChild: (self newDocsExplorer).
	
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> newDocsExplorer [
	^ self
		newHeaderCardWithTitle: 'Glamorous Toolkit'
		description: 'Read the Glamorous Toolkit book.'
		size: 150 @ 200
		content:
			(BrLabel new
				text: 'Glamorous Toolkit Book';
				aptitude: BrGlamorousLabelAptitude new
					bold;
				padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			self
				showSpaceWithTitle: 'Documentation'
				with:
					(GtInspector
						createOn: GtRlGToolkitDocumentationExplorer buildForGToolkitProject)
				from: card ]
]
