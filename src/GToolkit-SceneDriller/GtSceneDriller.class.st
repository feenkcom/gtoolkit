Class {
	#name : #GtSceneDriller,
	#superclass : #BrPager,
	#instVars : [
		'targetContainer',
		'selectedElement',
		'inspector',
		'elementsTree'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #initialization }
GtSceneDriller >> initialize [
	super initialize.
	
	self
		matchParent;
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		look: BrProportionalHorizontalPagerLook new
]

{ #category : #initialization }
GtSceneDriller >> initializeWith: aTargetContainer [
	targetContainer := aTargetContainer.

	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.4 ];
		addChild: (self newSceneContainerFor: aTargetContainer)).
		
	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.6 ];
		addChild: (self newPagerFor: aTargetContainer)).

	self addChildren: { 
		self newCloseButtonFor: aTargetContainer }
]

{ #category : #accessing }
GtSceneDriller >> inspectElement: anElement [
	selectedElement == anElement
		ifTrue: [ ^ self ].

	selectedElement := anElement.
	elementsTree phlow spawnObject: selectedElement
]

{ #category : #'instance creation' }
GtSceneDriller >> newCloseButtonFor: aTargetContainer [
	^ BrButton new
		look: BrGlamorousButtonCircularLook + BrGlamorousButtonIconLook + BrGlamorousButtonFlatExteriorLook + BrGlamorousButtonLayoutLook;
		icon: [ (BrGlamorousVectorIcons close asElement
				outskirts: BlOutskirts centered;
				background: Color gray;
				border: (BlBorder paint: Color transparent width: 0.8)) ] asStencil;
		beLargeSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop.
			c margin: (BlInsets top: 5) ];
		action: [ :e | e fireEvent: GtSceneDrillerHideWish new ]
]

{ #category : #'instance creation' }
GtSceneDriller >> newElementsTree [	
	^ BrSimpleTree new
		matchParent;
		padding: (BlInsets top: 5);
		rowStencil: (GtSceneDrillerTreeRowStencilBuilder new
			whenHovered: [ :anEvent |
				| thisRow thisRowValue |
				
				thisRow := anEvent currentTarget.
				thisRowValue := (elementsTree nodeAt: thisRow constraints infinite holder dataSourcePosition) value.
				thisRow fireEvent: (GtSceneDrillerHighlightElementWish new element: thisRowValue) ];
			whenUnhovered: [ :anEvent | anEvent currentTarget fireEvent: (GtSceneDrillerHideHighlightWish new) ]);
		addEventHandler: (GtPhlowListToSelectHandler new transformation: (GtPhlowSendTransformation object: [ :aTreeNode | aTreeNode value ]));
		when: GtPhlowObjectEvent do: [ :anEvent | self fireEvent: (GtSceneDrillerSelectElementWish new element: anEvent object) ];
	  nodeStencil: [
			BrLabel new
				beSmallSize;
				look: BrGlamorousLabelLook new ];
		nodeDataBinder: [ :eachLabel :eachElement |
			| aLabelText |
			
			aLabelText := eachElement class name asRopedText.
			eachElement id = BlElementId noId
				ifFalse: [ aLabelText, '   ' asRopedText,
					(eachElement id asRopedText
						foreground: Color veryDarkGray;
						background: (Color gray alpha: 0.1)) ].

			aLabelText, '   ' asRopedText,
				(('h: ' asRopedText, eachElement constraints horizontal resizer asString asLowercase asRopedText) foreground: Color darkGray).
			aLabelText, '   ' asRopedText,
				(('v: ' asRopedText, eachElement constraints vertical resizer asString asLowercase asRopedText) foreground: Color darkGray).

			eachLabel text: aLabelText.
			eachLabel ];
		yourself
]

{ #category : #'instance creation' }
GtSceneDriller >> newPagerFor: aTargetContainer [	
	^ BrVerticalPane new
		matchParent;
		constraintsDo: [ :c | c linear weight: 0.7 ];
		padding: (BlInsets top: 10 left: 10 bottom: 10 right: 0);
		addLook: BrShadowLook new beLarge;
		background: BrGlamorousColors backdropColor;
		addChildren: {
			self newSectionLabel text: 'Details'.
			(GtPager createWrappedOn: (BrVerticalPane new
				matchParent;
				addChild: (BrLabel new
					look: BrGlamorousLabelLook;
					hMatchParent;
					padding: (BlInsets top: 10.0 right: 12.0 bottom: 10.0 left: 12.0);
					background: BrGlamorousColors defaultHeaderBackgroundColor;
					text: 'Elements');
				addChild: (elementsTree := self newElementsTree))) id: '#gtoolkit-driller--pager'
		}
]

{ #category : #'instance creation' }
GtSceneDriller >> newSceneContainerFor: aTargetContainer [

	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		constraintsDo: [ :c | c linear weight: 0.3 ];
		padding: (BlInsets all: 20);
		addChildren: { 
			self newSectionLabel text: 'Scene'.
			BlElement new height: 10; width: 0.

			BlScalableElement new
				fitWidth;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				addLook: (BrShadowLook new beLarge color: BrGlamorousColors defaultShadowColor darker);
				background: Color white;
				addChild: aTargetContainer
		}
]

{ #category : #'instance creation' }
GtSceneDriller >> newSectionLabel [
	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color darkGray)
]

{ #category : #accessing }
GtSceneDriller >> selectElement: anElement [
	| wasNil |
	selectedElement == anElement
		ifTrue: [ ^ self ].
	
	wasNil := selectedElement isNil.
	selectedElement := anElement.
	
	elementsTree items: targetContainer children lazy: [ :each | each children ].
	elementsTree expandSuchThat: [ :aTreeNode | (selectedElement hasParent: aTreeNode value) or: [ selectedElement == aTreeNode value ] ].
	elementsTree selectAndScrollTo: selectedElement.
	elementsTree phlow spawnObject: selectedElement.
	
	wasNil ifTrue: [
		self
			childWithId: '#gtoolkit-driller--pager'
			ifFound: [ :aPager |
				aPager maximizePageContentIn: aPager pages first contentElement ]
			ifNone: [  ] ]
]

{ #category : #accessing }
GtSceneDriller >> targetContainer [
	^ targetContainer
]
