Class {
	#name : #GtWorldTabElement,
	#superclass : #BlElement,
	#instVars : [
		'tabs',
		'home'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtWorldTabElement class >> spaceCloseButtonName [
	^ #'gt-world--space-close-button'
]

{ #category : #accessing }
GtWorldTabElement class >> tabNameForSpaceId: aNumber [
	^ GtWorldSpaceTabId spaceId: aNumber
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeElement [
	^ BrLabel new
		text: 'Home';
		look: (BrGlamorousLabelLook new 
			fontSize: 42; 
			foreground: BrGlamorousColors disabledButtonTextColor);
		matchParent;
		alignCenter;
		background: Color white
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeTab [
	^ BrTab new
		vExact: 36;
		look: BrGlamorousSpaceTabWithIconLook;
		icon: self defaultHomeTabIcon;
		label: 'Home';
		stencil: [ self home ]
]

{ #category : #defaults }
GtWorldTabElement >> defaultHomeTabIcon [
	^ BrGlamorousVectorIcons gt
]

{ #category : #'private - accessing' }
GtWorldTabElement >> home [
	^ home
]

{ #category : #initialization }
GtWorldTabElement >> initialize [
	super initialize.
	self initializeHomeElement.
	self initializeTabGroup.
	self initializeTabs.
	self initializeElement.
	self initializeShortcuts.
	self initializeListeners.
]

{ #category : #initialization }
GtWorldTabElement >> initializeElement [
	self addChild: tabs as: GtWorldTabGroupId.
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #initialization }
GtWorldTabElement >> initializeHomeElement [
	home := self defaultHomeElement
]

{ #category : #initialization }
GtWorldTabElement >> initializeListeners [
	"Subclasses may register listeners"
]

{ #category : #initialization }
GtWorldTabElement >> initializeShortcuts [
	"Subclasses may initialize shortcuts"
]

{ #category : #initialization }
GtWorldTabElement >> initializeTabGroup [
	tabs := BrTabGroup new.
	tabs look: BrGlamorousSpaceTabGroupLook new.
	tabs actionbarStencil: [ self newActionbar ].
]

{ #category : #initialization }
GtWorldTabElement >> initializeTabs [
	tabs addTab: self defaultHomeTab
]

{ #category : #'private - instance creation' }
GtWorldTabElement >> newActionItemsInto: anActionbar [
	"Subclasses may add action items into the World toolbar"
]

{ #category : #'private - instance creation' }
GtWorldTabElement >> newActionbar [
	| anActionbar |

	anActionbar := BrToolbar new.
	anActionbar look: BrGlamorousToolbarLook new.
	
	self newActionItemsInto: anActionbar.

	^ anActionbar
]

{ #category : #accessing }
GtWorldTabElement >> newToolbarForTabModel: aTabModel [
	^ BrToolbar new
		look: (BrGlamorousToolbarLook new spacing: 0);
		margin: (BlInsets left: 6);
		addItems:
			{(BrButton new
				icon: BrGlamorousIcons maximize;
				exact: 16 @ 16;
				opacity: 0.5;
				look: GtWorldTabToolbarButtonLook;
				model: aTabModel;
				label: 'Open in a new window';
				action: [ :aButtonElement | 
					tabs viewModel removeTab: aButtonElement model.
					self space class
						openWithSpaces: {aButtonElement model model}
						from: self space ]).
			(BrButton new
				icon: BrGlamorousVectorIcons close;
				exact: 16 @ 16;
				opacity: 0.5;
				look: GtWorldTabToolbarButtonLook;
				label: 'Close';
				model: aTabModel;
				containerName: self class spaceCloseButtonName;
				action: [ :aButtonElement | tabs viewModel removeTab: aButtonElement model ])}
]

{ #category : #releasing }
GtWorldTabElement >> prepareForRelease [
	"Space sends this message to be saved as part of a release process.
	Subclasses may trigger relevant actions."
	
]

{ #category : #'system startup & shutdown' }
GtWorldTabElement >> refreshContent [
	"Refresh the content of the space. Is only called for a default space instance on start-up.
	Subclasses may trigger relevant actions."
]

{ #category : #'api - opening' }
GtWorldTabElement >> showSpace: aSpace [
	self showSpace: aSpace select: true
]

{ #category : #accessing }
GtWorldTabElement >> showSpace: aSpace select: shouldBeSelected [
	| aTab |
	aTab := BrTab new
		vExact: 36;
		model: aSpace;
		look: BrGlamorousSpaceTabWithLabelLook new;
		label: aSpace title;
		containerName: (self class tabNameForSpaceId: aSpace id);
		stencil: [ :aTabModel | 
			| anActualSpace |
			anActualSpace := aTabModel model.
			anActualSpace root hasParent
				ifTrue: [ anActualSpace root removeFromParent ]
				ifFalse: [ anActualSpace root dispatchRemovedFromSceneGraph ].

			aTabModel widgetDo: [ :aWidget |
				aWidget enqueueTask: (GtWorldReEnqueueTasks new previousSpace: anActualSpace).
				anActualSpace root addEventHandler: (GtWorldChangeTabAppearanceChangeHandler new tab: aWidget) ].
			anActualSpace root
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ];
		actionbarStencil:
				[ :aTabModel | self newToolbarForTabModel: aTabModel ].
	aTab selected: shouldBeSelected.
	tabs addTab: aTab.
	aTab := nil
]

{ #category : #'private - accessing' }
GtWorldTabElement >> tabs [
	<return: #BrTabGroup>
	^ tabs
]

{ #category : #'children accessing' }
GtWorldTabElement >> topMostParent [
	^ self
]
