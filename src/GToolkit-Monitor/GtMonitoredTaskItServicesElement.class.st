Class {
	#name : #GtMonitoredTaskItServicesElement,
	#superclass : #BlElement,
	#instVars : [
		'servicesList'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredTaskItServicesElement class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Space Monitor'.
	aSpace addChild: (GtInspector createOn: self new).
	aSpace extent: 1280@800.
	aSpace show
]

{ #category : #initialization }
GtMonitoredTaskItServicesElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	servicesList := BrColumnedList new.
	servicesList addEventHandler: (GtInspectorListToSelectHandler new
		transformation: [ :aMonitoredService | aMonitoredService service ifNil: [ aMonitoredService ] ]).
	servicesList rowStencil: (BrListClickableRowStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	servicesList column
		title: 'Service';
		stencil: [ :aMonitoredService |
			| aTitle |
			
			aTitle := aMonitoredService title.
			aTitle isEmptyOrNil ifTrue: [ 
				aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	servicesList column
		title: 'Running';
		stencil: [ :aMonitoredService |
			| isOpened |

			isOpened := aMonitoredService exists
				ifTrue: [ aMonitoredService isRunning
					ifTrue: [ 'Running' asRopedText bold ]
					ifFalse: [ 'Inactive' asRopedText ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: isOpened;
				hExact: 100 ].
		
	self addChild: servicesList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredTaskItServicesElement >> updateList [
	self enqueueTask: (BlEnqueuedTaskItAction new
		name: '[Monitor] TaskIt Services';
		action: [
			| allServices |
			allServices := TKTConfiguration serviceManager services copy.
			allServices := allServices collect: [ :eachService | GtMonitoredTaskItService new service: eachService ].
			allServices := allServices sorted: [ :a :b | a title < b title ].
			allServices ];
		onFailureEnqueueAction: [ :anException | 
			'Failed to update TaskIt services list' traceCr.
			anException traceCr ];
		onSuccessEnqueueAction: [ :theServices |
			servicesList display: theServices.
			self enqueueTask: (BlDelayedTaskAction new delay: 5 seconds; action: [ self updateList ]) ])
]
