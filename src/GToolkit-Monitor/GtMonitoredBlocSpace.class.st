Class {
	#name : #GtMonitoredBlocSpace,
	#superclass : #Object,
	#instVars : [
		'space',
		'announcer'
	],
	#category : #'GToolkit-Monitor-Bloc Spaces'
}

{ #category : #accessing }
GtMonitoredBlocSpace >> allPathsTo [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ (ReferenceFinder findAllPathsTo: self space) sorted: [ :a :b | a size < b size ] ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
GtMonitoredBlocSpace >> changed [
	"Receiver changed in a general way; inform all the dependents by 
	sending each dependent an update: message."

	self announcer announce: Announcement new
]

{ #category : #actions }
GtMonitoredBlocSpace >> close [
	self space ifNotNil: [ :aSpace | aSpace close ].
	self changed
]

{ #category : #actions }
GtMonitoredBlocSpace >> disableShutdownOnClose [
	self space ifNotNil: [ :aSpace | aSpace removeEventHandlersSuchThat: [ :h |  h isKindOf: BlSpaceShutdownOnCloseListener ] ].
	self changed
]

{ #category : #actions }
GtMonitoredBlocSpace >> enableShutdownOnClose [
	self space ifNotNil: [ :aSpace | aSpace addEventHandler: BlSpaceShutdownOnCloseListener new ].
	self changed
]

{ #category : #testing }
GtMonitoredBlocSpace >> exists [
	^ self space isNotNil
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtActionsFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Actions';
		priority: 1;
		updateWhen: Announcement in: self announcer;
		stencil: [
			(BrVerticalPane new
				vFitContent;
				hMatchParent;
				cellSpacing: 5;
				addChild: (BrHorizontalPane new
					vFitContent;
					hMatchParent;
					cellSpacing: 5;
					alignCenterLeft;
					addChildren: (self shouldShutdownOnClose
						ifTrue: [ {
							BrLabel new
								look: BrGlamorousLabelLook new;
								text: 'When closed I will shutdown GToolkit'.
							BrButton new
								look: BrGlamorousButtonWithLabelLook new;
								label: 'Disable';
								action: [ self disableShutdownOnClose ].
						}]
						ifFalse: [ { 
							BrLabel new
								look: BrGlamorousLabelLook new;
								text: 'When closed I will not shutdown GToolkit'.
							BrButton new
								look: BrGlamorousButtonWithLabelLook new;
								label: 'Enable';
								action: [ self enableShutdownOnClose ]
						 } ]));
				addChild: (BrHorizontalPane new
					vFitContent;
					hMatchParent;
					cellSpacing: 5;
					alignCenterLeft;
					addChildren: (self isRunning
						ifTrue: [ {
							BrLabel new
								look: BrGlamorousLabelLook new;
								text: 'The space is running'.
							BrButton new
								look: BrGlamorousButtonWithLabelLook new;
								label: 'Close';
								action: [ self close ].
						}]
						ifFalse: [ { 
							BrLabel new
								look: BrGlamorousLabelLook new;
								text: 'The space is not running'.
						 } ]))) asScrollableElement
		]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtAllPathsToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'All paths';
		priority: 12;
		items: [ self allPathsTo ];
		column: 'Paths from Smalltalk' 
			item: [ :anObject | anObject gtDisplayText ];
		column: 'Length' 
			item: [ :anObject | anObject size ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPathToFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Path';
		priority: 11;
		items: [ self pathTo ];
		column: 'Path from Smalltalk' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPointersFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Pointers';
		priority: 10;
		items: [ self pointers ];
		column: 'Pointers' 
			item: [ :anObject | anObject gtDisplayText ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpace >> gtPreviewFor: aView [
	<gtView>
	self space ifNil: [ ^ aView empty ].
	^ self space gtPreviewFor: aView
]

{ #category : #testing }
GtMonitoredBlocSpace >> isDead [
	^ self isRunning not
]

{ #category : #testing }
GtMonitoredBlocSpace >> isRunning [
	^ self space
		ifNil: [ false ]
		ifNotNil: [ :aSpace | aSpace isOpened ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> pathTo [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ ReferenceFinder findPathTo: self space ]
		ifFalse: [ {  } ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> pointers [
	Smalltalk garbageCollectMost.

	^ self exists
		ifTrue: [ self space pointersTo reject: [ :eachObject | eachObject isKindOf: WeakArray ] ]
		ifFalse: [ {  } ]
]

{ #category : #testing }
GtMonitoredBlocSpace >> shouldShutdownOnClose [
	^ self space
		ifNil: [ false ]
		ifNotNil: [ :aSpace |
			aSpace eventDispatcher handlersDo: [ :eachEventHandler |
				(eachEventHandler isKindOf: BlSpaceShutdownOnCloseListener)
					ifTrue: [ ^ true ] ].
		false ]
]

{ #category : #accessing }
GtMonitoredBlocSpace >> space [
	<return: #BlSpace or: nil>

	^ space at: 1
]

{ #category : #accessing }
GtMonitoredBlocSpace >> space: aSpace [
	space := aSpace asWeakReference
]

{ #category : #accessing }
GtMonitoredBlocSpace >> title [
	^ self space title
]
