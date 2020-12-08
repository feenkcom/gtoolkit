"
I show a barchart of where each bar represents a frame and how long it took it to complete
"
Class {
	#name : #GtProfilerPerformanceChart,
	#superclass : #BrVerticalPane,
	#instVars : [
		'currentLogger',
		'profiledSpace',
		'toolbar',
		'startButton',
		'stopButton',
		'resetButton',
		'isPaused'
	],
	#category : #'GToolkit-Profiler'
}

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> computeIsRunning [
	^ profiledSpace notNil
		and: [ profiledSpace space telemetry = BlNullTelemetry uniqueInstance
			and: [ currentLogger notNil
				and: [ currentLogger isRunning ] ] ]
]

{ #category : #initialization }
GtProfilerPerformanceChart >> initialize [
	super initialize.
	
	self matchParent.
	self alignTopCenter.
	self padding: (BlInsets all: 10).
	
	isPaused := false.
	
	toolbar := BrToolbar new
		look: BrGlamorousToolbarLook new.
	
	startButton := BrButton new
		disable;
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: 'Start';
		action: [ :aButton | self start ].

	stopButton := BrButton new
		disable;
		beSmallSize;
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Stop';
		action: [ self stop ].
		
	resetButton := BrButton new
		disable;
		look: BrGlamorousButtonWithLabelLook new;
		beSmallSize;
		label: 'Reset';
		action: [ self reset ].

	toolbar addItems: { startButton . stopButton . resetButton }.
	
	self addChild: toolbar.
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> instrumentSpace [
	profiledSpace ifNotNil: [ :anOpenedSpace | self instrumentSpace: anOpenedSpace space ]
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> instrumentSpace: aSpace [
	aSpace enqueueTask: (BlTaskAction new action: [ aSpace telemetry: BlMemoryTelemetry new ])
]

{ #category : #'hooks - children' }
GtProfilerPerformanceChart >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	isPaused
		ifFalse: [ ^ self ].
	
	self startLogger.
	self instrumentSpace
]

{ #category : #'hooks - children' }
GtProfilerPerformanceChart >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	isPaused := self computeIsRunning.
	
	self stopLogger.
	self uninstrumentSpace
]

{ #category : #accessing }
GtProfilerPerformanceChart >> profileSpace: anOpenedSpace [
	profiledSpace = anOpenedSpace
		ifTrue: [ ^ self ].

	self
		stop;
		reset.

	self removeChildNamed: #chart.
	
	profiledSpace := anOpenedSpace.
	currentLogger := BlTelemetryLogger new.

	(currentLogger gtFramesFor: GtPhlowEmptyView new)
		asElementDo: [ :aChart | self addChild: aChart as: #chart ]
]

{ #category : #'api - profiler' }
GtProfilerPerformanceChart >> reset [
	self resetLogger
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> resetLogger [
	currentLogger ifNotNil: [ :aLogger | aLogger reset ].
]

{ #category : #'api - profiler' }
GtProfilerPerformanceChart >> start [
	self
		instrumentSpace;
		startLogger.
		
	stopButton enable.
	startButton disable.
	resetButton disable
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> startLogger [
	currentLogger ifNotNil: [ :aLogger | aLogger start ].
]

{ #category : #'api - profiler' }
GtProfilerPerformanceChart >> stop [
	self
		stopLogger;
		uninstrumentSpace.

	stopButton disable.
	startButton enable.
	resetButton enable
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> stopLogger [
	currentLogger ifNotNil: [ :aLogger | aLogger stop ].
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> uninstrumentSpace [
	profiledSpace ifNotNil: [ :anOpenedSpace | self uninstrumentSpace: anOpenedSpace space ]
]

{ #category : #'private - profiling' }
GtProfilerPerformanceChart >> uninstrumentSpace: aSpace [
	aSpace enqueueTask: (BlTaskAction new action: [
		aSpace telemetry: BlNullTelemetry uniqueInstance ])
]
