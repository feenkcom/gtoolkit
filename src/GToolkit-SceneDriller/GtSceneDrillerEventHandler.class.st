"
! Scene Driller Event Handler
Is used to add support of the ==Scene Driller== to arbitrary elements. For the best result the element to which ==Scene Driller= is added should have a ${class:BlBasicLayout}$ and have ==matchParent== or ==exact== layout resizing strategy.
!! Usage
Press ==shift+alt== to enable element highlight mode and then click on the highlighted element to select it in the ==Scene Driller==
!! More
See ${class:GtSceneDriller}$ for the main UI of the ==Scene Driller== and ${class:GtSceneDrillerOverlay}$ for an overlay over the scene that shows highlighted and selected elements.
"
Class {
	#name : #GtSceneDrillerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mousePosition',
		'hasDriller',
		'elementToHighlight',
		'elementToSelect',
		'shouldLockOverlay',
		'hasOverlay',
		'originalTitle'
	],
	#classVars : [
		'DrillerId',
		'DrillerOverlayId',
		'KeyCombination'
	],
	#category : #'GToolkit-SceneDriller-Driller'
}

{ #category : #'class initialization' }
GtSceneDrillerEventHandler class >> initialize [
	DrillerId := #'gtoolkit-driller'.
	DrillerOverlayId := BlElementId named: #'gtoolkit-driller--preview'.
	KeyCombination := BlKeyCombination builder dnf alt shift build
]

{ #category : #'private - accessing' }
GtSceneDrillerEventHandler >> childToDrillAt: aPoint in: aTargetElement ifFound: aFoundBlock ifNone: aNoneBlock [
	| theChildrenAt |
	theChildrenAt := aTargetElement withAllLeafChildrenAt: aPoint.
	
	hasOverlay
		ifTrue: [
			self
				drillerOverlayIn: aTargetElement
				do: [ :aDrillerOverlay | theChildrenAt := theChildrenAt copyWithout: self ] ].

	theChildrenAt := theChildrenAt sorted: [ :a :b | a compositionDepth > b compositionDepth ].
	theChildrenAt ifEmpty: [ ^ aNoneBlock value ].

	^ aFoundBlock value: theChildrenAt first
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> clickEvent: aClickEvent [
	| aDrillerTarget anElementToSelect |

	hasOverlay
		ifFalse: [ ^ self ].

	aDrillerTarget := self drillerTargetIn: aClickEvent currentTarget.
	(aDrillerTarget containsGlobalPoint: aClickEvent position)
		ifFalse: [ ^ self ].
		
	(self highlightCombinationMatchesIn: aClickEvent currentTarget)
		ifFalse: [ ^ self ].

	hasDriller
		ifFalse: [ self hideOverlayIn: aClickEvent currentTarget ].

	anElementToSelect := self
		childToDrillAt: aClickEvent localPosition
		in: aClickEvent currentTarget
		ifFound: #yourself
		ifNone: [ nil ].

	self showDriller: aClickEvent currentTarget.
	self showOverlayIn: aClickEvent currentTarget.

	anElementToSelect
		ifNotNil: [
			self
				drillerIn: aClickEvent currentTarget
				do: [ :aSceneDriller | aSceneDriller selectElement: anElementToSelect ] ]
]

{ #category : #'private - accessing' }
GtSceneDrillerEventHandler >> drillerIn: aTargetElement do: aBlock [
	aTargetElement
		childWithId: DrillerId
		ifFound: aBlock
		ifNone: [  ]
]

{ #category : #'private - accessing' }
GtSceneDrillerEventHandler >> drillerOverlayIn: aRootElement do: aBlock [
	aRootElement
		childWithId: DrillerOverlayId
		ifFound: aBlock
		ifNone: [  ]
]

{ #category : #'private - accessing' }
GtSceneDrillerEventHandler >> drillerTargetIn: aRootElement [
	self
		drillerIn: aRootElement
		do: [ :aSceneDriller | ^ aSceneDriller targetContainer ].
		
	^ aRootElement
]

{ #category : #'api - accessing' }
GtSceneDrillerEventHandler >> eventsToHandle [
	^ {
		GtSceneDrillerShowWish.
		GtSceneDrillerHideWish.
		GtSceneDrillerHighlightElementWish.
		GtSceneDrillerHideHighlightWish.
		GtSceneDrillerSelectElementWish.
		BlKeyDownEvent.
		BlKeyUpEvent.
		BlMouseMoveEvent.
		BlClickEvent
	}
]

{ #category : #'api - driller' }
GtSceneDrillerEventHandler >> hideDriller: aRootElement [
	self unlockOverlay.
	self hideOverlayIn: aRootElement.
	self selectElement: nil in: aRootElement.
	self highlightElement: nil in: aRootElement.

	hasDriller
		ifFalse: [ ^ self ].

	hasDriller := false.
	(aRootElement isAttachedToSceneGraph and: [ originalTitle notNil ])
		ifTrue: [ aRootElement space title: originalTitle ].
		
	originalTitle := nil.

	aRootElement
		childWithId: DrillerId
		ifFound: [ :aSceneDriller |
			| aTargetElementChildren |
			aTargetElementChildren := aSceneDriller targetContainer children asArray.
			aSceneDriller targetContainer removeChildren.
			aRootElement removeChildren.
			aRootElement addChildren: aTargetElementChildren.
			self flag: #TODO.
			"https://github.com/feenkcom/gtoolkit/issues/1749".
			aRootElement withAllChildrenBreadthFirstDo: [ :eachChild | eachChild boundsCache invalidateBoundsInSpace ] ]
		ifNone: [ ^ self ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> hideDrillerEvent: aHideDrillerEvent [
	self hideDriller: aHideDrillerEvent currentTarget
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> hideHighlightEvent: aHideHighlightEvent [
	self
		highlightElement: nil
		in: aHideHighlightEvent currentTarget
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> hideOverlayIn: aRootElement [
	hasOverlay
		ifFalse: [ ^ self ].

	hasOverlay := false.	
	aRootElement removeChildNamed: DrillerOverlayId
]

{ #category : #'private - testing' }
GtSceneDrillerEventHandler >> highlightCombinationMatchesIn: aRootElement [
	<return: #Boolean>

	aRootElement isAttachedToSceneGraph
		ifFalse: [ ^ false ].

	^ KeyCombination matches: aRootElement space keyboardProcessor buffer
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> highlightElement: anElement in: aRootElement [
	elementToHighlight := anElement.

	self drillerOverlayIn: aRootElement do: [ :anOverlay | anOverlay highlightElement: anElement ]
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> highlightElementAt: aPoint in: aRootElement [
	| aDrillerTarget |

	mousePosition := aPoint.
	"moving mouse inside of the driller target resets the explicit element to highlight"
	elementToHighlight := nil.

	hasOverlay
		ifFalse: [ ^ self ].

	(self highlightCombinationMatchesIn: aRootElement)
		ifFalse: [ ^ self ].

	aDrillerTarget := self drillerTargetIn: aRootElement.
	
	self drillerOverlayIn: aRootElement do: [ :anOverlay |
		anOverlay highlightElement: (self
			childToDrillAt: (aDrillerTarget globalPointToLocal: (aRootElement localPointToGlobal: aPoint))
			in: aDrillerTarget
			ifFound: #yourself
			ifNone: [ nil ]) ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> highlightElementEvent: aHighlightElementEvent [
	self
		highlightElement: aHighlightElementEvent element
		in: aHighlightElementEvent currentTarget
]

{ #category : #initialization }
GtSceneDrillerEventHandler >> initialize [
	super initialize.
	
	mousePosition := 0@0.

	hasOverlay := false.
	hasDriller := false.
	shouldLockOverlay := false.
	
	elementToHighlight := nil.
	elementToSelect := nil
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> keyDownEvent: aKeyDownEvent [
	self keyEvent: aKeyDownEvent
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> keyEvent: aKeyEvent [
	(self highlightCombinationMatchesIn: aKeyEvent currentTarget)
		ifTrue: [ self showOverlayIn: aKeyEvent currentTarget ]
		ifFalse: [ self maybeHideOverlayIn: aKeyEvent currentTarget ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> keyUpEvent: aKeyDownEvent [
	self keyEvent: aKeyDownEvent
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> lockOverlay [
	shouldLockOverlay := true
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> maybeHideOverlayIn: aRootElement [
	hasOverlay
		ifFalse: [ ^ self ].
	
	self drillerOverlayIn: aRootElement do: [ :anOverlay | anOverlay preventMeAndChildrenMouseEvents ].
		
	shouldLockOverlay
		ifTrue: [
			self highlightElement: elementToHighlight in: aRootElement.
			^ self ].

	aRootElement isAttachedToSceneGraph
		ifFalse: [ ^ self hideOverlayIn: aRootElement ].

	"only hide if the wrong combination is pressed"
	(KeyCombination matches: aRootElement space keyboardProcessor buffer)
		ifFalse: [ self hideOverlayIn: aRootElement ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> mouseMoveEvent: aMouseMoveEvent [
	| aDrillerTarget |

	aDrillerTarget := self drillerTargetIn: aMouseMoveEvent currentTarget.
	(aDrillerTarget containsGlobalPoint: aMouseMoveEvent position)
		ifTrue: [
			self
				highlightElementAt: aMouseMoveEvent localPosition
				in: aMouseMoveEvent currentTarget ]
		ifFalse: [ mousePosition := nil ] 
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> selectElement: anElement in: aRootElement [
	elementToSelect := anElement.

	self drillerOverlayIn: aRootElement do: [ :anOverlay | anOverlay selectElement: anElement ]
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> selectElementEvent: aSelectElementEvent [
	self
		selectElement: aSelectElementEvent element
		in: aSelectElementEvent currentTarget
]

{ #category : #'api - driller' }
GtSceneDrillerEventHandler >> showDriller: aRootElement [
	| aTargetElementChildren aTargetContainer |

	hasDriller
		ifTrue: [ ^ self ].
		
	self lockOverlay.
	
	aRootElement isAttachedToSceneGraph
		ifTrue: [
			originalTitle := aRootElement space title.
			aRootElement space title: 'Glamorous Scene Driller' ].

	hasDriller := true.

	aTargetElementChildren := aRootElement children asArray.
	aRootElement removeChildren.

	aTargetContainer := BlElement new.
	aTargetContainer size: aRootElement extent.
	aTargetContainer addChildren: aTargetElementChildren.

	aRootElement addChild: (GtSceneDriller new initializeWith: aTargetContainer) as: DrillerId
]

{ #category : #'event handling' }
GtSceneDrillerEventHandler >> showDrillerEvent: aShowHaloEvent [
	aShowHaloEvent consumed: true.

	self showDriller: aShowHaloEvent currentTarget
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> showOverlayIn: aRootElement [
	hasOverlay
		ifTrue: [
			(elementToHighlight isNil and: [ mousePosition notNil ])
				ifTrue: [ self highlightElementAt: mousePosition in: aRootElement ].
				
			self drillerOverlayIn: aRootElement do: [ :anOverlay | anOverlay allowMeAndChildrenMouseEvents ].
			^ self ].

	hasOverlay := true.

	(self drillerTargetIn: aRootElement)
		addChild: (GtSceneDrillerOverlay new highlightElement: elementToHighlight; selectElement: elementToSelect; allowMeAndChildrenMouseEvents)
		as: DrillerOverlayId.

	(elementToHighlight isNil and: [ mousePosition notNil ])
		ifTrue: [ self highlightElementAt: mousePosition in: aRootElement ]
]

{ #category : #'api - overlay' }
GtSceneDrillerEventHandler >> unlockOverlay [
	shouldLockOverlay := false
]
