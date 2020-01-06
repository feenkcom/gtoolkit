Class {
	#name : #GtHomeDocumentationSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtHomeDocumentationSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'Docs').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self
			 newCardWithTitle: 'Main documentation'
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
			 newCardWithTitle: 'The Inspector'
			 description:
			 'The Inspector'
			 picture:
				 (((GtDocument new text:  (BaselineOfGToolkitInspector comment first: 500)) 
					   gtTextFor: GtPhlowView empty) asElementDo: [ :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'The Inspector'
					 with:
					 (GtInspector withToolOn:
						  (GtDocument forClass: BaselineOfGToolkitInspector))
					 from: card ]).
	cardsContainer addChild: (self
			 newCardWithTitle: 'The Playground'
			 description:
			 'The Playground'
			 picture:
				 (((GtDocument new text:  (BaselineOfGToolkitPlayground comment first: 500)) 
					   gtTextFor: GtPhlowView empty) asElementDo: [ :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'The Playground'
					 with:
					 (GtInspector withToolOn:
						  (GtDocument forClass: BaselineOfGToolkitPlayground))
					 from: card ]).
	
	cardsContainer addChild: (self
			 newCardWithTitle: 'Moldable development'
			 description:
			 'What exactly is moldable development?'
			 picture:
				 (((GtDocument new text: (GtMoldableDevelopmentExplanation comment first: 500)) 
					   gtTextFor: GtPhlowView empty) asElementDo: [ :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Moldable development'
					 with:
					 (GtInspector withToolOn:
						  (GtDocument forClass: GtMoldableDevelopmentExplanation))
					 from: card ]).
	cardsContainer addChild: (self
			 newCardWithTitle: 'What makes Bloc special'
			 description:
			 'An overview of the key properties of Bloc, the graphical stack.'
			 picture:
				 (((GtDocument new text: (GtWhatMakesBlocSpecialExplanation comment first: 500)) 
					   gtTextFor: GtPhlowView empty) asElementDo: [ :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'What makes Bloc special'
					 with:
					 (GtInspector withToolOn:
						  (GtDocument forClass: GtWhatMakesBlocSpecialExplanation))
					 from: card ]).

	cardsContainer addChild: (self
			 newCardWithTitle: 'Examples'
			 description: 'Examples are both tests and units of documentation.'
			 picture: ((GtRlGToolkitExamplesExplorer buildForGToolkitProject 
					   gtViewAllExamplesInImageFor: GtPhlowView empty) asElementDo: [ 
					  :e | e ])
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Examples'
					 with: (GtInspector createOn:
							  GtRlGToolkitExamplesExplorer buildForGToolkitProject)
					 from: card ]).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
