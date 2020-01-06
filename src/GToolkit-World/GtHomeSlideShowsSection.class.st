Class {
	#name : #GtHomeSlideShowsSection,
	#superclass : #GtHomeSection,
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtHomeSlideShowsSection >> create [
	| sectionContainer cardsContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newHeaderLabel: 'Slide Shows').
	cardsContainer := self newCardsContainer.
	cardsContainer addChild: (self
			 newCardWithTitle: 'Tour'
			 description:
			 'Take an interative tour through the tools and engines.'
			 picture:
				 (GtTitleSlide new titleText: ('glamoroustoolkit' asRopedText
						   fontSize: 30;
						   fontName: 'Helvetica Neue';
						   bold;
						   in: [ :title | (title from: 1 to: 'glamorous' size) thin ];
						   yourself))
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Tour'
					 with: GtTour new create makeArrowsVisible
					 from: card ]).
	cardsContainer addChild: (self
			 newCardWithTitle: 'One rendering tree'
			 description: 'All rendering relies on a single tree at a time.'
			 picture: (GtTitleSlide new titleText:
					  ('One rendering tree' asRopedText glamorousRegularFont 
						   fontSize: 30))
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'One rendering tree'
					 with: GtOneRenderingTree new create makeArrowsVisible
					 from: card ]).
	cardsContainer addChild: (self
			 newCardWithTitle: 'Pharo 101'
			 description: 'New to Pharo? Take an introductory tutorial.'
			 picture: (GtTitleSlide new titleText:
					  ('Pharo 101' asRopedText glamorousRegularFont fontSize: 30))
			 action: [ :card | 
				 self
					 showSpaceWithTitle: 'Pharo 101'
					 with: GtPharo101 new create makeArrowsVisible
					 from: card ]).
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]
