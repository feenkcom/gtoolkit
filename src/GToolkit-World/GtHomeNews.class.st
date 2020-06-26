Class {
	#name : #GtHomeNews,
	#superclass : #BlElement,
	#category : #'GToolkit-World-UI'
}

{ #category : #testing }
GtHomeNews >> hasNewsItems [
	^ self hasChildren 
]

{ #category : #initialization }
GtHomeNews >> initialize [
	super initialize.
	self layout: BlLinearLayout horizontal.
 
	self initializeNews.
]

{ #category : #initialization }
GtHomeNews >> initializeNews [
	| availableNews |
	availableNews := { 
		"self newCoderNews.
		self newPlaygroundNews" }.
	availableNews do: [ :aNews |
		aNews status: (self statusRegistry statusForNewsId: aNews id) ].
	
	availableNews 
		select: [ :aNews | aNews status isViewed not ]
		thenDo:[ :aNews |
			self addChild: aNews cardStencil create ]
]

{ #category : #'instance creation' }
GtHomeNews >> newCoderButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Coder';
		id: 'tools/coder';
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card |
			self
				showSpaceWithTitle: 'Coder'
				with: GtCoderStencil new create
				from: card.
			self statusRegistry markNewsViewedForId: 'tools/coder' ];
		description: 'Browse and manipulate code.'
]

{ #category : #'instance creation' }
GtHomeNews >> newCoderNews [
	^ GtNewsItem new
		cardStencil: self newCoderButtonStencil
]

{ #category : #'instance creation' }
GtHomeNews >> newPlaygroundButtonStencil [
	^ GtToolButtonStencil new 
		title: 'Playground';
		id: 'tools/playground';
		icon: BrGlamorousVectorIcons largePlay;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Playground'
				with: GtPlaygroundStencil new create
				from: card.
			self statusRegistry markNewsViewedForId: 'tools/playground' ];
		description: 'Play with code. Live.'
]

{ #category : #'instance creation' }
GtHomeNews >> newPlaygroundNews [
	^ GtNewsItem new
		cardStencil: self newPlaygroundButtonStencil 
]

{ #category : #'instance creation' }
GtHomeNews >> showSpaceWithTitle: aString with: anElement from: anotherElement [
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: aString.
	aSpace extent: 1200@600.
	aSpace addChild: anElement asElement.
	aSpace withHalos.
	anotherElement showSpace: aSpace
]

{ #category : #accessing }
GtHomeNews >> statusRegistry [
	^ GtNewsItemsStatusRegistry defaultInstance
]
