Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'Documentation').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self
			 newCardWithTitle: 'Documentation'
			 description:
			 'Start from the central point and inspect your way through the docs.'
			 picture:
				 (((GtDocument new text: (BaselineOfGToolkit comment first: 500)) 
					   gtTextFor: GtPhlowView empty) asElementDo: [ :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Documentation'
					 with:
					 (GtInspector withToolOn:
						  (GtDocument forClass: BaselineOfGToolkit))
					 from: card ]).
	cardsContainer addChild: (self
			 newCardWithTitle: 'Examples'
			 description: 'Examples are both tests and units of documentation.'
			 picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject 
					   gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [ 
					  :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Documentation'
					 with: (GtInspector createOn:
							  GtRlGToolkitExamplesExplorer buildForGToolkitProject)
					 from: card ]).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
