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
		"self takeATourNews" }.
	availableNews do: [ :aNews |
		aNews status: (self statusRegistry statusForNewsId: aNews id) ].
	
	availableNews 
		select: [ :aNews | aNews status isViewed not ]
		thenDo:[ :aNews |
			self addChild: aNews cardStencil create ]
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

{ #category : #'instance creation' }
GtHomeNews >> takeATourNews [
	^ GtNewsItem new
		id: 'slide/take-a-tour';
		cardStencil: self takeATourStencil
]

{ #category : #'instance creation' }
GtHomeNews >> takeATourStencil [
	^ GtNewsCardStencil new
		headerText: 'New to Glamorous Toolkit?';
		actionText: 'Take a tour';
		tooltipText: 'Take an interactive tour through tools and engines';
		action: [ :card |
			self
				showSpaceWithTitle: 'Tour'
				with: GtTour new create makeArrowsVisible
				from: card.
			self statusRegistry markNewsViewedForId: 'slide/take-a-tour' ] 
]
