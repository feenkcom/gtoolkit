Class {
	#name : #GtMonitoredBlocSpacesElement,
	#superclass : #BlElement,
	#instVars : [
		'spacesList'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredBlocSpacesElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #initialization }
GtMonitoredBlocSpacesElement >> initialize [
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
			
			aTitle := aMonitoredSpace exists
				ifTrue: [ aMonitoredSpace title trimmed ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			aTitle ifEmpty: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	spacesList column
		title: 'Opened';
		stencil: [ :aMonitoredSpace |
			| isOpened |

			isOpened := aMonitoredSpace exists
				ifTrue: [ aMonitoredSpace isRunning
					ifTrue: [ 'Running' asRopedText bold ]
					ifFalse: [ 'Dead' asRopedText foreground: Color red darker; bold ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: isOpened;
				hMatchParent ].
		
	self addChild: spacesList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredBlocSpacesElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedTaskItAction new
				name: '[Monitor] Bloc spaces';
				element: self;
				action: [ | allSpaces |
					allSpaces := BlSpace allSubInstances
						sorted: [ :a :b | a title < b title ].
					allSpaces := allSpaces sorted: [ :a :b | a isOpened ].
					allSpaces := allSpaces
						collect: [ :eachSpace | GtMonitoredBlocSpace new space: eachSpace ].
					allSpaces ];
				onFailureEnqueueAction: [ 'Failed to update Spaces list' traceCr ];
				onSuccessEnqueueAction: [ :theSpaces | 
					spacesList items: theSpaces.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]
