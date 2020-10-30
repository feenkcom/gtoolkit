Class {
	#name : #GtWorldElement,
	#superclass : #GtWorldTabElement,
	#instVars : [
		'spotterDropdown',
		'subSpaceDropdown',
		'notificationsDropdown'
	],
	#classVars : [
		'WorldSpotterSize'
	],
	#category : #'GToolkit-World-UI'
}

{ #category : #accessing }
GtWorldElement class >> worldSpotterSize [
	^ WorldSpotterSize ifNil: [ WorldSpotterSize := 640@480 ]
]

{ #category : #accessing }
GtWorldElement class >> worldSpotterSize: aPoint [
	WorldSpotterSize := aPoint
]

{ #category : #defaults }
GtWorldElement >> defaultHomeElement [
	^ GtHome new
]

{ #category : #initialization }
GtWorldElement >> initializeListeners [
	super initializeListeners.
	
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
]

{ #category : #initialization }
GtWorldElement >> initializeShortcuts [
	super initializeShortcuts.
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
]

{ #category : #'private - instance creation' }
GtWorldElement >> newActionItemsInto: anActionbar [
	super newActionItemsInto: anActionbar.
	anActionbar addItem: self newNotificationsBadge.
	anActionbar addItem: self newSpotterButton.
	anActionbar addItem: self newSubSpaceButton.
]

{ #category : #'private - instance creation' }
GtWorldElement >> newNotificationsBadge [
	self 
		assert: [ notificationsDropdown isNil ]
		description: [ 'Notifications dropdown is already created!' ].
	
	notificationsDropdown := GtNotificationsBadgeElement new
		addLook: (BrGlamorousLabelTooltipLook new text: 'Notifications');
		hide.
	
	^ notificationsDropdown
]

{ #category : #'private - instance creation' }
GtWorldElement >> newSpotterButton [
	self 
		assert: [ spotterDropdown isNil ]
		description: [ 'Spotter dropdown is already created!' ].
	
	spotterDropdown :=  GtSpotterDropdownButtonStencil new
		tooltip: 'Search';
		extent: self class worldSpotterSize;
		spotterElementDo: [ :aSpotterElement |
			aSpotterElement 
				when: GtSpotterResizedEvent 
				do: [ :e | self class worldSpotterSize: e target size ] ];
		asElement.
	spotterDropdown look - BrGlamorousButtonExteriorLook.
		
	^ spotterDropdown
]

{ #category : #'private - instance creation' }
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
									BrGlamorousButtonWithIconLook - BrGlamorousButtonWithLabelTooltipLook
										- BrGlamorousButtonExteriorLook;
								icon: BrGlamorousIcons hamburger;
								label: 'Menu';
								yourself ]
						content: [ GtToolsMenu new
								constraintsDo: [ :c | 
									c vertical fitContent.
									c horizontal exact: 420 ];
								yourself ]);
		icon: BrGlamorousIcons hamburger;
		label: 'Menu';
		yourself.
	^ subSpaceDropdown
]

{ #category : #'hooks - children' }
GtWorldElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
		send: #update:
		to: self home. 

	SystemAnnouncer uniqueInstance weak
		when: MethodAnnouncement
		send: #update:
		to: self home. 
]

{ #category : #'hooks - children' }
GtWorldElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	SystemAnnouncer uniqueInstance unsubscribe: self home
]

{ #category : #updating }
GtWorldElement >> prepareForRelease [
	self home prepareForRelease
]

{ #category : #updating }
GtWorldElement >> refreshContent [
	"Refresh all notifications in the home screen."
	self home refreshNotifications
]

{ #category : #'api - notification' }
GtWorldElement >> showNotification: aNotification [

	"We want to display notifications only in a default space ID (window)."
	self space ifNotNil: [ :mySpace |
		BlSpace
			spaceWithId: GtWorld defaultId 
			do: [ :aSpace | 
				aSpace ~= mySpace ifTrue: [
					aSpace showNotification: aNotification.
					^ self ] ] ].

	"I am a root element of the default space ID, I will display the notification."
	notificationsDropdown ifNotNil: [ :anElement | 
		"Notification may come from any process"
		anElement enqueueTask: (BlTaskAction new action: [ 
			anElement notification: aNotification ]) ]
]
