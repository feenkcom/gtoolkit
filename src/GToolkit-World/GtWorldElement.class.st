Class {
	#name : #GtWorldElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown',
		'tabs',
		'home'
	],
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorldElement >> home [
	^ home
]

{ #category : #initialization }
GtWorldElement >> initialize [
	super initialize.
	tabs := BrTabGroup new.
	tabs look: BrGlamorousSpaceTabGroupLook new.
	tabs actionbarStencil: [ self newActionbar ].
	home := GtHome new.
	tabs
		addTab:
			(BrTab new
				vExact: 36;
				look: BrGlamorousSpaceTabWithIconLook;
				icon: BrGlamorousIcons gt asElement;
				label: 'Home';
				stencil: [ home ]).
	self
		addShortcut:
			(BlShortcut new
				repeatable: false;
				combination: BlKeyCombination shiftReturn;
				action: [ spotterDropdown
						ifNotNil: [ spotterDropdown
								dispatchEvent:
									(BrDropdownShowWish new
										anchor: spotterDropdown;
										yourself) ] ]).
	self
		addShortcut:
			(BlShortcut new
				repeatable: false;
				combination: BlKeyCombination primaryT;
				action: [ subSpaceDropdown
						ifNotNil: [ subSpaceDropdown
								dispatchEvent:
									(BrDropdownShowWish new
										anchor: subSpaceDropdown;
										yourself) ] ]).
	self
		when: GtSpawnSpotter
		do: [ :e | 
			e consumed: true.
			spotterDropdown
				ifNotNil: [ spotterDropdown
						dispatchEvent:
							(BrDropdownShowWish new
								anchor: spotterDropdown;
								yourself) ] ].
	self addChild: tabs.
	self
		constraintsDo: [ :c | 
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
			BrGlamorousButtonWithIconLook - BrGlamorousButtonExteriorLook
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
												size: 800 @ 500;
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
			BrGlamorousButtonWithIconLook - BrGlamorousButtonExteriorLook
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
									c horizontal exact: 420 ];
								yourself ]);
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Menu';
		yourself.
	^ subSpaceDropdown
]

{ #category : #initialization }
GtWorldElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	SystemAnnouncer uniqueInstance weak
		when: (ClassAnnouncement where: [ :ann | ann classAffected = GtHome ])
		send: #update:
		to: self home. 

	SystemAnnouncer uniqueInstance weak
		when: (MethodAnnouncement where: [ :ann | ann classAffected = GtHome ])
		send: #update:
		to: self home. 
]

{ #category : #initialization }
GtWorldElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	SystemAnnouncer uniqueInstance unsubscribe: self home
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
			aSpace root hasParent
				ifTrue: [ aSpace root removeFromParent ]
				ifFalse: [ aSpace root dispatchRemovedFromSceneGraph ].
			aSpace root
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ];
		actionbarStencil: [
			BrToolbar new
				look: BrGlamorousToolbarLook new;
				addItems: {
					BrButton new
						exact: 20@12;
						opacity: 0.5;
						look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousWithLabelTooltipLook;
						icon: BrGlamorousIcons maximize;
						label: 'Open in a new window';
						action: [
							tabs removeTab: aTab.
							GtWorld openWithSpaces: { aSpace } ].
					BrButton new
						exact: 20@12;
						opacity: 0.5;
						look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousWithLabelTooltipLook;
						icon: BrGlamorousIcons close;
						label: 'Close';
						action: [ tabs removeTab: aTab ] } ]).

	tabs addTab: aTab
]

{ #category : #'children accessing' }
GtWorldElement >> topMostParent [
	^ self
]
