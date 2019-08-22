Class {
	#name : #GtWorldSpace,
	#superclass : #BlSpace,
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorldSpace class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := GtWorldSpace new.
	aSpace title: 'World'.
	aSpace showSpace: (GtWorld create).
	aSpace show
]

{ #category : #initialization }
GtWorldSpace >> defaultRoot [
	| aTabGroup |

	aTabGroup := BrTabGroup new.
	aTabGroup look: BrGlamorousSpaceTabGroupLook new.
	aTabGroup actionbarStencil: [ self newActionbar ].

	^ super defaultRoot addChild: aTabGroup as: #tabs
]

{ #category : #'instance - creation' }
GtWorldSpace >> newActionbar [
	| anActionbar |
	
	anActionbar := BrToolbar new.
	anActionbar look: BrGlamorousToolbarLook new.
	anActionbar addItem: self newSpotterButton.
	
	^ anActionbar
]

{ #category : #'instance - creation' }
GtWorldSpace >> newSpotterButton [
	| dropdown |

	dropdown := BrDropdown new.
	dropdown
		look: (BrGlamorousDropdownLook new outskirtsEmbellisher: [ :e | e background: BrGlamorousColors secondaryHeaderBackgroundColor ]);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		toggle: [ BrButton new
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons search asElement;
			when: BlElementBackgroundChangedEvent
				do: [ :e | 
					(dropdown isExpanded and: [ e target background paint color ~= BrGlamorousColors secondaryHeaderBackgroundColor ])
						ifTrue: [ e target background: BrGlamorousColors secondaryHeaderBackgroundColor ] ] ];
		popup: [ | model |
			model := GtSpotter new.
			model announcer
				when: GtSpotterExitAnnouncement
				do: [ :e | dropdown collapse ].
			GtSpotterElementWithPreview new
				spotterModel: model;
				size: 600@400;
				margin: (BlInsets all: 1);
				geometry: (BlRectangle cornerRadius: 4);
				yourself ];
		yourself.
		
	^ dropdown
]

{ #category : #'api - displaying' }
GtWorldSpace >> showSpace: aSpace [
	| aTab |
	
	aTab := nil.
	aTab := (BrTab new
		look: BrGlamorousSpaceTabLook new;
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
