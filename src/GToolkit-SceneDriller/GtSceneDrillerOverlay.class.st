Class {
	#name : #GtSceneDrillerOverlay,
	#superclass : #BlElement,
	#instVars : [
		'highlight',
		'selection',
		'elementToHighlight',
		'elementToSelect'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #accessing }
GtSceneDrillerOverlay >> hidePreview [
]

{ #category : #accessing }
GtSceneDrillerOverlay >> highlightElement: anElementOrNil [
	elementToHighlight := anElementOrNil.

	anElementOrNil
		ifNil: [ highlight visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
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
	
	highlight := BlPolygonElement new background: (Color r: 1.0 g: 0.8396871945259042 b: 0.3998044965786901 alpha: 0.2).
	highlight visibility: BlVisibility gone.
	
	selection := BlPolygonElement new background: BrGlamorousColors selectedListItemColor.
	selection visibility: BlVisibility gone.

	self addChild: highlight.
	self addChild: selection
]

{ #category : #'hooks - geometry' }
GtSceneDrillerOverlay >> onExtentChanged [
	super onExtentChanged.
	
	elementToSelect ifNotNil: [ :anOverlayedElement | self updateOverlayElement: selection toMatch: anOverlayedElement ].
	elementToHighlight ifNotNil: [ :anOverlayedElement | self updateOverlayElement: highlight toMatch: anOverlayedElement ].
]

{ #category : #accessing }
GtSceneDrillerOverlay >> selectElement: anElementOrNil [	
	elementToSelect := anElementOrNil.

	anElementOrNil
		ifNil: [ selection visibility: BlVisibility gone ]
		ifNotNil: [ :anElement |
			self updateOverlayElement: selection toMatch: anElement.
			selection visibility: BlVisibility visible ]
]

{ #category : #accessing }
GtSceneDrillerOverlay >> showPreviewFor: aChildToPreview in: aDrillerTarget [
]

{ #category : #private }
GtSceneDrillerOverlay >> updateOverlayElement: anOverlayElement toMatch: anOverlayedElement [
	| theAnchorPositions |

	theAnchorPositions := anOverlayedElement bounds inLocal bounds corners
		collect: [ :eachPoint | self globalPointToLocal: (anOverlayedElement localPointToGlobal: eachPoint) ].

	anOverlayElement vertices: theAnchorPositions
]
