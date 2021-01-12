Class {
	#name : #GtSceneDriller,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'targetContainer'
	],
	#category : #'GToolkit-SceneDriller'
}

{ #category : #initialization }
GtSceneDriller >> initialize [
	super initialize.
	
	self
		matchParent;
		padding: (BlInsets top: 20 bottom: 20);
		weightSum: 3;
		cellSpacing: 20.
]

{ #category : #initialization }
GtSceneDriller >> initializeWith: aTargetContainer [
	targetContainer := aTargetContainer.

	self addChildren: { 
			self newSceneContainerFor: aTargetContainer.
			self newElementsTreeFor: aTargetContainer.
			self newElementInspectorFor: aTargetContainer.
			self newCloseButtonFor: aTargetContainer }
]

{ #category : #'instance creation' }
GtSceneDriller >> newCloseButtonFor: aTargetContainer [
	^ GtInspectorRoundButtonStencil new asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: 5 left: 0 bottom: 0 right: 5).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e | e fireEvent: GtSceneDrillerHideWish new ]
]

{ #category : #'instance creation' }
GtSceneDriller >> newElementInspectorFor: aTargetContainer [
	^ BrVerticalPane new
		matchParent;
		constraintsDo: [ :c | c linear weight: 1.25 ];
		addChildren: { 
			BrLabel new
				look: (BrGlamorousLabelLook new foreground: Color gray);
				text: 'Inspector'.
		
			(GtInspector newOn: aTargetContainer withAllChildrenBreadthFirst atRandom)
				margin: (BlInsets all: 5);
				addLook: BrShadowLook new;
				background: Color white
		}
]

{ #category : #'instance creation' }
GtSceneDriller >> newElementsTreeFor: aTargetContainer [
	^ BrVerticalPane new
		matchParent;
		constraintsDo: [ :c | c linear weight: 0.75 ];
		addChildren: { 
			BrLabel new
				look: (BrGlamorousLabelLook new foreground: Color gray);
				text: 'Elements'.
		
			BrSimpleTree new
				matchParent;
				margin: (BlInsets all: 5);
				addLook: BrShadowLook;
				background: Color white;
				nodeStencil: [ BrLabel new look: BrGlamorousLabelLook new ];
				nodeDataBinder: [ :eachLabel :eachElement | eachLabel text: eachElement printString ];
				items: aTargetContainer children lazy: [ :each | each children ];
				expandAll
		}
]

{ #category : #'instance creation' }
GtSceneDriller >> newSceneContainerFor: aTargetContainer [
	^ BrVerticalPane new
		matchParent;
		addChildren: { 
			BrLabel new
				look: (BrGlamorousLabelLook new foreground: Color gray);
				text: 'Scene'.
		
			BlZoomableElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: aTargetContainer;
				effect: BrGlamorousShadowEffect new;
				margin: (BlInsets all: 5);
				zoomLevel: 0.5
		}
]

{ #category : #accessing }
GtSceneDriller >> targetContainer [
	^ targetContainer
]
