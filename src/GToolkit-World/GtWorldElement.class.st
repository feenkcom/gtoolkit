Class {
	#name : #GtWorldElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown',
		'tabs'
	],
	#category : #'GToolkit-World'
}

{ #category : #initialization }
GtWorldElement >> initialize [
	super initialize.

	tabs := BrTabGroup new.
	tabs look: BrGlamorousSpaceTabGroupLook new.
	tabs actionbarStencil: [ self newActionbar ].
	
	tabs addTab: (BrTab new
		vExact: 36;
		look: BrGlamorousSpaceTabWithIconLook;
		icon: BrGlamorousIcons gt asElement;
		label: 'Home';
		stencil: [ GtHome new asScrollableElement background: Color white]).
	
	self addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination shiftReturn;
		action: [ spotterDropdown ifNotNil: #expand ]).
	self addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination primaryT;
		action: [ subSpaceDropdown ifNotNil: #expand ]).
	self when: GtSpawnSpotter do: [:e | 
		e consumed: true.
		spotterDropdown ifNotNil: #expand ].
		
	self addChild: tabs.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #'instance creation' }
GtWorldElement >> newActionbar [
	| anActionbar |

	anActionbar := BrToolbar new.
	anActionbar look: BrGlamorousToolbarLook new.
	anActionbar addItem: self newSpotterButton.
	anActionbar addItem: self newSubSpaceButton.

	^ anActionbar
]

{ #category : #initialization }
GtWorldElement >> newSpotterButton [

	self
		assert: [ spotterDropdown isNil ]
		description: [ 'Spotter dropdown is already created!' ].

	spotterDropdown := BrDropdown new
		look: (BrGlamorousDropdownLook new backgroundPaint: BrGlamorousColors secondaryHeaderBackgroundColor);
		toggle: [
			BrButton new
				look: (BrGlamorousButtonWithIconLook - BrGlamorousButtonExteriorLook + BrGlamorousDropdownToggleLook);
				icon: BrGlamorousIcons search asElement;
				label: 'Search' ];
		popup: [
			| model |
			model := GtSpotter new.
			model announcer
				when: GtSpotterExitAnnouncement
				do: [ :e | spotterDropdown collapse ].
			GtSpotterElementWithPreview new
				spotterModel: model;
				size: 600@400;
				margin: (BlInsets all: 1);
				geometry: (BlRectangle cornerRadius: 4);
				yourself ];
		yourself.
		
	^ spotterDropdown
]

{ #category : #initialization }
GtWorldElement >> newSubSpaceButton [
	
	self
		assert: [ subSpaceDropdown isNil ]
		description: [ 'Sub-space dropdown is already created!' ].
	
	subSpaceDropdown := BrDropdown new
		look: BrGlamorousDropdownLook new;
		toggle: [
			BrButton new
				look: (BrGlamorousButtonWithIconLook - BrGlamorousButtonExteriorLook + BrGlamorousDropdownToggleLook);
				icon: BrGlamorousIcons hamburger asElement;
				label: 'Menu' ];
		popup: [
			GtToolsMenu new
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal exact: 200 ] ];
		yourself.

	^ subSpaceDropdown
]

{ #category : #'api - opening' }
GtWorldElement >> showSpace: aSpace [
	| aTab |

	aTab := nil.
	aTab := (BrTab new
		vExact: 36;
		look: BrGlamorousSpaceTabWithLabelLook new;
		select;
		label: aSpace title;
		stencil: [
			aSpace root dispatchRemovedFromSceneGraph.
			aSpace root
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ];
		actionbarStencil: [
			BrButton new
				exact: 20@12;
				opacity: 0.5;
				margin: (BlInsets top: 2 left: 4 bottom: 0 right: 0);
				look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousButtonWithLabelTooltipLook;
				icon: BrGlamorousIcons close;
				label: 'Close';
				action: [ tabs removeTab: aTab ] ]).

	tabs addTab: aTab
]

{ #category : #'children accessing' }
GtWorldElement >> topMostParent [
	^ self
]
