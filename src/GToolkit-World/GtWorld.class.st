Class {
	#name : #GtWorld,
	#superclass : #BlSpace,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown'
	],
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := GtWorld new.
	aSpace title: 'Glamorous Toolkit'.
	aSpace fullsize: true.
	aSpace show
]

{ #category : #initialization }
GtWorld >> defaultRoot [
	| aTabGroup |

	aTabGroup := BrTabGroup new.
	aTabGroup look: BrGlamorousSpaceTabGroupLook new.
	aTabGroup actionbarStencil: [ self newActionbar ].
	
	aTabGroup addTab: (BrTab new
		vExact: 36;
		look: BrGlamorousSpaceTabWithIconLook;
		icon: BrGlamorousIcons gt asElement;
		label: 'Home';
		stencil: [ GtHome new ]).

	^ super defaultRoot addChild: aTabGroup as: #tabs
]

{ #category : #initialization }
GtWorld >> initialize [
	super initialize.
	
	self root addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination shiftReturn;
		action: [ spotterDropdown ifNotNil: #expand ]).
	self root addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination primaryT;
		action: [ subSpaceDropdown ifNotNil: #expand ]).
]

{ #category : #'instance - creation' }
GtWorld >> newActionbar [
	| anActionbar |

	anActionbar := BrToolbar new.
	anActionbar look: BrGlamorousToolbarLook new.
	anActionbar addItem: self newSpotterButton.
	anActionbar addItem: self newSubSpaceButton.

	^ anActionbar
]

{ #category : #'instance - creation' }
GtWorld >> newSpotterButton [

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

{ #category : #'instance - creation' }
GtWorld >> newSubSpaceButton [
	
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

{ #category : #'api - displaying' }
GtWorld >> showSpace: aSpace [
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
				action: [ (self root childNamed: #tabs) removeTab: aTab ] ]).

	(self root childNamed: #tabs) addTab: aTab
]
