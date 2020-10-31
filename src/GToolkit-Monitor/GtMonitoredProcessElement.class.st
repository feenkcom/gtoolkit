Class {
	#name : #GtMonitoredProcessElement,
	#superclass : #GtMonitoredServiceElement,
	#instVars : [
		'stackList'
	],
	#category : #'GToolkit-Monitor'
}

{ #category : #initialization }
GtMonitoredProcessElement >> initialize [
	super initialize.
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	stackList := BrSimpleList new.
	stackList
		stencil: [ :eachContext | (GtMethodCoder forMethod: eachContext) asCoderUIModel expanded: false; asElement  ].
	self addChild: stackList.
	self updateList.
]

{ #category : #accessing }
GtMonitoredProcessElement >> stack [
	^ self service ifNotNil: #stack ifNil: [ #() ]
]

{ #category : #updating }
GtMonitoredProcessElement >> updateList [
	self
		enqueueTask:
			(BlEnqueuedTaskItAction new
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
