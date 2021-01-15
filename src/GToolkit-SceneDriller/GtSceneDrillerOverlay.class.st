Class {
	#name : #GtSceneDrillerOverlay,
	#superclass : #BlElement,
	#instVars : [
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect',
		'eventHandler'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #private }
GtSceneDrillerOverlay >> addEventHandlerToElementToHighlightOrSelect: anElement [
	((elementToSelect = anElement or: [ elementToHighlight = anElement ]) and: [ (anElement hasEventHandler: eventHandler) not ])
		ifTrue: [ anElement addEventHandler: eventHandler ]
]

{ #category : #accessing }
GtSceneDrillerOverlay >> hideElement: anElement [
	(elementToHighlight = anElement or: [ elementToHighlight isNil ])
		ifTrue: [ highlight visibility: BlVisibility gone ].

	(elementToSelect = anElement or: [ elementToSelect isNil ])
		ifTrue: [ selection visibility: BlVisibility gone ]
]

{ #category : #accessing }
GtSceneDrillerOverlay >> highlightElement: anElementOrNil [
	| aPreviousElementToHighlight |
	
	aPreviousElementToHighlight := elementToHighlight.
	elementToHighlight := anElementOrNil.

	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToHighlight.
	
	anElementOrNil
		ifNil: [ highlight visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			self updateOverlayElement: highlight toMatch: anElement.
			highlight visibility: BlVisibility visible ]
]

{ #category : #initialization }
GtSceneDrillerOverlay >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c ignoreByLayout.
		c horizontal matchParent.
		c vertical matchParent ].
	self beInSeparateCompositionLayer.
	
	eventHandler := GtSceneDrillerOverlayEventHandler new overlay: self.
	
	highlight := BlPolygonElement new background: (Color r: 1.0 g: 0.8396871945259042 b: 0.3998044965786901 alpha: 0.2).
	highlight visibility: BlVisibility gone.
	
	selection := BlPolygonElement new background: BrGlamorousColors selectedListItemColor.
	selection visibility: BlVisibility gone.

	self addChild: highlight.
	self addChild: selection
]

{ #category : #'hooks - children' }
GtSceneDrillerOverlay >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	elementToHighlight ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ].
	elementToSelect ifNotNil: [ :anElement | self addEventHandlerToElementToHighlightOrSelect: anElement ].
]

{ #category : #'hooks - geometry' }
GtSceneDrillerOverlay >> onExtentChanged [
	super onExtentChanged.
	
	self updatePositions
]

{ #category : #'hooks - children' }
GtSceneDrillerOverlay >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	elementToHighlight ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ].
	elementToSelect ifNotNil: [ :anElement | anElement removeEventHandler: eventHandler ].
]

{ #category : #private }
GtSceneDrillerOverlay >> removeEventHandlerFromElementToHighlightOrSelect: anElement [
	"Only remove an event handler if an element is not to select and not to highlight"
	
	(elementToSelect ~= anElement and: [ elementToHighlight ~= anElement and: [ anElement notNil ] ])
		ifTrue: [ anElement removeEventHandler: eventHandler ]
]

{ #category : #accessing }
GtSceneDrillerOverlay >> selectElement: anElementOrNil [
	| aPreviousElementToSelect |

	aPreviousElementToSelect := elementToSelect.
	elementToSelect := anElementOrNil.

	self removeEventHandlerFromElementToHighlightOrSelect: aPreviousElementToSelect.

	anElementOrNil
		ifNil: [ selection visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
			self addEventHandlerToElementToHighlightOrSelect: anElement.
			self updateOverlayElement: selection toMatch: anElement.
			selection visibility: BlVisibility visible ]
]

{ #category : #accessing }
GtSceneDrillerOverlay >> showElement: anElement [
	(elementToHighlight = anElement)
		ifTrue: [ highlight visibility: BlVisibility visible ].
	elementToHighlight ifNil: [ highlight visibility: BlVisibility gone ].	
	
	(elementToSelect = anElement)
		ifTrue: [ selection visibility: BlVisibility visible ].
	elementToSelect ifNil: [ selection visibility: BlVisibility gone ].	
]

{ #category : #private }
GtSceneDrillerOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	| theAnchorPositions |

	theAnchorPositions := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].

	anOverlayElement vertices: theAnchorPositions
]

{ #category : #private }
GtSceneDrillerOverlay >> updatePositions [
	elementToSelect ifNotNil: [ :anOverlayedElement | self updateOverlayElement: selection toMatch: anOverlayedElement ].
	elementToHighlight ifNotNil: [ :anOverlayedElement | self updateOverlayElement: highlight toMatch: anOverlayedElement ].
]
