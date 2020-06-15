"
I display a list of opened ${class:BlSpace}$
"
Class {
	#name : #GtMonitorOpenedSpacesElement,
	#superclass : #BlElement,
	#instVars : [
		'spacesList'
	],
	#category : #'GToolkit-Monitor-Space Profiler'
}

{ #category : #'instance creation' }
GtMonitorOpenedSpacesElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #accessing }
GtMonitorOpenedSpacesElement >> allOpenedSpaces [
	| openedSpaces |

	openedSpaces := BlSpace allSubInstances
		select: [ :eachSpace | eachSpace isOpened ].

	openedSpaces := openedSpaces sorted: [ :a :b | a title < b title ].
	openedSpaces := openedSpaces collect: [ :eachSpace | GtMonitorOpenedSpace new space: eachSpace ].
	
	^ openedSpaces
]

{ #category : #initialization }
GtMonitorOpenedSpacesElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	spacesList := BrColumnedList new.
	spacesList addEventHandler: (GtInspectorListToSelectHandler new).
	spacesList rowStencil: (BrListClickableRowStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	spacesList column
		title: 'Space';
		stencil: [ :aMonitoredSpace |
			| aTitle |
			
			aTitle := aMonitoredSpace title trimmed.
			aTitle ifEmpty: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	spacesList column
		title: 'Opened';
		stencil: [ :aMonitoredSpace |
			| isOpened |

			isOpened := aMonitoredSpace isRunning
				ifTrue: [ 'Running' asRopedText bold ]
				ifFalse: [ 'Dead' asRopedText foreground: Color red darker; bold ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: isOpened;
				hMatchParent ].
		
	self addChild: spacesList.
	
	self updateList
]

{ #category : #updating }
GtMonitorOpenedSpacesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedTaskItAction new
				name: '[Monitor] Bloc spaces';
				element: self;
				action: [ self allOpenedSpaces ];
				onFailureEnqueueAction: [ 'Failed to update Spaces list' traceCr ];
				onSuccessEnqueueAction: [ :theSpaces | 
					spacesList items: theSpaces.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]
