Class {
	#name : #GtMonitoredUniversesElement,
	#superclass : #BrHorizontalFlow,
	#category : #'GToolkit-Monitor'
}

{ #category : #initialization }
GtMonitoredUniversesElement >> createUniverseCard: aUniverse [
	| aContainer |
	
	aContainer := BlElement new
		layout: BlLinearLayout vertical.
	aContainer viewModel: (BrInteractiveModel new addState: (BrHoverModel new)).
	aContainer addLook: (BrInteractiveCommonLook new
		default: [ :w | w border: (BlBorder paint: Color veryVeryLightGray width: 1) ];
		hovered: [ :w | w border: (BlBorder paint: BrGlamorousColors hoveredButtonBorderColor width: 1) ]).
	
	aContainer
		constraintsDo: [ :c |
			c horizontal exact: 150.
			c vertical exact: 100 ];
		background: Color white;
		margin: (BlInsets all: 7);
		padding: (BlInsets all: 1);
		addLook: (BrShadowLook new).

	aContainer when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: aUniverse ].

	aContainer addChild: (self createUniverseName: aUniverse).
	aContainer addChild: (self createUniverseRunning: aUniverse).
	aContainer addChild: (self createUniverseSpaces: aUniverse).

	^ aContainer
]

{ #category : #initialization }
GtMonitoredUniversesElement >> createUniverseName: aUniverse [
	| aNameLabel |

	aNameLabel := BrLabel new
		padding: (BlInsets all: 4);
		look: BrGlamorousLabelLook;
		text: aUniverse hostClass label;
		asScalableElement.
	
	aNameLabel fitWidth.
	aNameLabel constraintsDo: [ :c | c vertical fitContent ].
	aNameLabel maxScale: 1.
	aNameLabel background: (Color veryVeryLightGray).

	^ aNameLabel
]

{ #category : #initialization }
GtMonitoredUniversesElement >> createUniverseRunning: aUniverse [
	| aNameLabel |

	aNameLabel := BrLabel new
		padding: (BlInsets left: 5 right: 5);
		look: BrGlamorousLabelLook;
		text: 'Running: ', aUniverse hostClass isRunning asString.

	^ aNameLabel
]

{ #category : #initialization }
GtMonitoredUniversesElement >> createUniverseSpaces: aUniverse [
	| aNameLabel |

	aNameLabel := BrLabel new
		padding: (BlInsets left: 5 right: 5);
		look: BrGlamorousLabelLook;
		text: 'Spaces: ', aUniverse spaces size asString.

	^ aNameLabel
]

{ #category : #initialization }
GtMonitoredUniversesElement >> initialize [
	super initialize.

	self matchParent.

	self updateList.
	self enqueueTask:
		(BlRepeatedTaskAction new
			delay: 2 seconds;
			action: [ self updateList ])
]

{ #category : #initialization }
GtMonitoredUniversesElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self updateList
]

{ #category : #initialization }
GtMonitoredUniversesElement >> updateList [
	| theUniverses |
	
	theUniverses := BlParallelUniverse all.
	self removeChildren.
	self addChildren: (theUniverses collect: [ :eachUniverse | self createUniverseCard: eachUniverse ])
]
