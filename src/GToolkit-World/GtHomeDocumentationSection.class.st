Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Docs').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkit).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitInspector).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitPlayground).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitCoder).
	cardsContainer addChild: (self newDocCardForClass: BaselineOfGToolkitSpotter).
	cardsContainer addChild: (self newDocCardForClass: GtMoldableDevelopmentExplanation).
	cardsContainer addChild: (self newDocCardForClass: GtWhatMakesBlocSpecialExplanation).
	cardsContainer addChild: (self newDocsExplorer).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> newDocsExplorer [	
	^ self 
		newHeaderCardWithTitle: 'Doc' 
		size: 150@200
		content: (BrLabel new text: 'More docs ...'; look: BrGlamorousLabelLook; padding: (BlInsets all: 20)) asScalableElement
		action: [ :card | 
			self
				showSpaceWithTitle: 'Documentation'
				with: (GtInspector createOn: GtRlGToolkitDocumentationExplorer buildForGToolkitProject)
				from: card ]
]
