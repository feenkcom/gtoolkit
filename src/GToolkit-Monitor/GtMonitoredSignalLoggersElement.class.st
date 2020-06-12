Class {
	#name : #GtMonitoredSignalLoggersElement,
	#superclass : #BlElement,
	#instVars : [
		'loggersList'
	],
	#category : #'GToolkit-Monitor-Beacon Loggers'
}

{ #category : #'instance creation' }
GtMonitoredSignalLoggersElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new title: 'Monitor'
]

{ #category : #initialization }
GtMonitoredSignalLoggersElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	loggersList := BrColumnedList new.
	loggersList addEventHandler: (GtInspectorListToSelectHandler new).
	loggersList rowStencil: (BrListClickableRowStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	loggersList column
		title: 'Logger';
		stencil: [ :aMonitoredLogger |
			| aTitle |
			
			aTitle := aMonitoredLogger exists
				ifTrue: [ aMonitoredLogger title trimmed ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			aTitle ifEmpty: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	loggersList column
		title: 'State';
		stencil: [ :aMonitoredLogger |
			| currentState |

			currentState := aMonitoredLogger exists
				ifTrue: [ aMonitoredLogger isRunning
					ifTrue: [ 'Running' asRopedText bold ]
					ifFalse: [ 'Stopped' asRopedText foreground: Color red darker; bold ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: currentState;
				hMatchParent ].
		
	self addChild: loggersList.
	
	self updateList
]

{ #category : #updating }
GtMonitoredSignalLoggersElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedTaskItAction new
				name: '[Monitor] Signal Loggers';
				element: self;
				action: [ | allLoggers |
					allLoggers := SignalLogger allSubInstances
						sorted: [ :a :b | a printString < b printString ].
					allLoggers := allLoggers sorted: [ :a :b | a isRunning ].
					allLoggers := allLoggers
						collect: [ :eachLogger | GtMonitoredSignalLogger new logger: eachLogger ].
					allLoggers ];
				onFailureEnqueueAction: [ 'Failed to update Loggers list' traceCr ];
				onSuccessEnqueueAction: [ :theLoggers | 
					loggersList items: theLoggers.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]
