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
	| look |
	self
		assert: [ spotterDropdown isNil ]
		description: [ 'Spotter dropdown is already created!' ].
	spotterDropdown := BrButton new
		look:
			BrGlamorousButtonWithIconLook
				+
					(look := BrGlamorousWithDropdownLook
						stencil: [ | model |
							model := GtSpotter new.
							model announcer
								when: GtSpotterExitAnnouncement
								do: [ :e | look hide ].
							BlElement new
								look:
									(BrGlamorousDropdownLook new
										handle:
											(BrButton new
												look:
													BrGlamorousButtonWithIconLook - BrGlamorousWithLabelTooltipLook
														- BrGlamorousButtonExteriorLook;
												icon: BrGlamorousIcons search asElement;
												yourself);
										content:
											(GtSpotterElement new
												spotterModel: model;
												size: 600 @ 400;
												yourself);
										yourself);
								background: BrGlamorousColors secondaryHeaderBackgroundColor;
								yourself ]);
		icon: BrGlamorousIcons search asElement;
		label: 'Search';
		yourself.
	^ spotterDropdown
]

{ #category : #initialization }
GtWorldElement >> newSubSpaceButton [
	self
		assert: [ subSpaceDropdown isNil ]
		description: [ 'Sub-space dropdown is already created!' ].
	subSpaceDropdown := BrButton new
		look:
			BrGlamorousButtonWithIconLook
				+
					(BrGlamorousWithDropdownLook
						handle: [ BrButton new
								look:
									BrGlamorousButtonWithIconLook - BrGlamorousWithLabelTooltipLook
										- BrGlamorousButtonExteriorLook;
								icon: BrGlamorousIcons hamburger asElement;
								label: 'Menu';
								yourself ]
						content: [ GtToolsMenu new
								constraintsDo: [ :c | 
									c vertical fitContent.
									c horizontal exact: 200 ];
								yourself ]);
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Menu';
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
				look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousWithLabelTooltipLook;
				icon: BrGlamorousIcons close;
				label: 'Close';
				action: [ tabs removeTab: aTab ] ]).

	tabs addTab: aTab
]

{ #category : #'children accessing' }
GtWorldElement >> topMostParent [
	^ self
]
