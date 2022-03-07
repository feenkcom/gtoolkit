Class {
	#name : #GtMonitoredProcessElement,
	#superclass : #GtMonitoredServiceElement,
	#instVars : [
		'stackList',
		'debugSession'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #initialization }
GtMonitoredProcessElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	stackList := BrSimpleList new.
	stackList stencil: [ :eachContext | 
		debugSession ifNil: [ Halt once ].
		(GtPharoMethodContextCoder forContext: eachContext session: debugSession)
			asCoderViewModel
			expanded: false;
			asElement ].
	self addChild: stackList
]

{ #category : #accessing }
GtMonitoredProcessElement >> service: aGtMonitoredProcess [

	| process |
	super service: aGtMonitoredProcess.
	process := aGtMonitoredProcess service.
	debugSession := DebugSession
		                named: 'Debug ' , process name
		                on: process
		                startedAt: process suspendedContext.
	self updateList
]

{ #category : #accessing }
GtMonitoredProcessElement >> stack [
	^ self service ifNotNil: #stack ifNil: [ #() ]
]

{ #category : #updating }
GtMonitoredProcessElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedFutureAction new
				name: '[Monitor] Process Stack Update';
				action: [ self stack ];
				element: self;
				onFailureEnqueueAction: [ :anException | 
					'Failed to update process stack' traceCr.
					anException traceCr ];
				onSuccessEnqueueAction: [ :theStackList | 
					stackList items: theStackList.
					self
						enqueueTask:
							(BlDelayedTaskAction new
								delay: 5 seconds;
								action: [ self updateList ]) ])
]
