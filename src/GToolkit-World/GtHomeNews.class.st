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
	self layout: BlLinearLayout vertical.
]

{ #category : #initialization }
GtHomeNews >> initializeNews [
	| availableNews validNews statusRegistry |
	availableNews := { 
		self takeATourNews }.
	
	statusRegistry := self statusRegistry.
	availableNews do: [ :aNews |
		aNews status: (statusRegistry statusForId: aNews id) ].
	
	validNews := availableNews reject: [ :aNews | 
		aNews status isViewed ].
	validNews 
		ifEmpty: [
			self visibility: BlVisibility gone ]
		ifNotEmpty: [ validNews do: [ :aNews |
			self visibility: BlVisibility visible.
			self addChild: aNews cardStencil create ] ]
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
	^ GtNewsItemsStatusRegistry loadDefault
]

{ #category : #'instance creation' }
GtHomeNews >> takeATourNews [
	^ GtNewsItem new
		id: 'news/take-a-tour';
		openAction: [ :cardElement |
			self
				showSpaceWithTitle: 'Tour'
				with: GtTour new create makeArrowsVisible
				from: cardElement ];
		cardStencil: self takeATourStencil
]

{ #category : #'instance creation' }
GtHomeNews >> takeATourStencil [
	^ GtNewsCardStencil new
		headerText: 'New to Glamorous Toolkit?';
		actionText: 'Take a tour';
		tooltipText: 'Take an interactive tour through tools and engines'
]

{ #category : #updating }
GtHomeNews >> updateWidget [
	self removeChildren.
	self initializeNews.
]
