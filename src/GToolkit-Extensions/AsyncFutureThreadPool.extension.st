Extension { #name : #AsyncFutureThreadPool }

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPool >> gtEnableTelemetryActionFor: anAction [
	<gtAction>
	| aTelemetry |
	
	aTelemetry := self telemetryDo: #yourself.
 
	^ anAction button
		tooltip: 'Enable telemetry';
		priority: 30;
		icon: BrGlamorousVectorIcons signal;
		action: [ self telemetryDo: #yourself ifNone: [ self telemetry: (aTelemetry := AsyncFutureThreadPoolTelemetry new) ] ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncFutureThreadPool >> gtWorkersFor: aView [
	<gtView>
	| aTelemetry |
	
	aTelemetry := self telemetryDo: #yourself ifNone: nil.
	
	^ aView columnedList
		title: 'Workers';
		priority: 10;
		items: [ workers asArray withIndexCollect: [ :each :index | each -> index ] ];
		column: 'Worker' text: [ :each | each value ] weight: 0.5;
		column: 'Name' text: [ :each |
			| aLabel |
			
			aLabel := each key group 
				ifNotNil: [ :aGroup | aGroup label ] 
				ifNil: [ '' ].
				
			aLabel := '{1} ({2})' format: { aLabel. each key priority gtDisplayString }.
			
			each key group 
			ifNotNil: [ :aGroup | aGroup isUnspecified 
				ifTrue: [ aLabel := aLabel asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]  ] .
			aLabel ];
		column: 'Tasks' text: [ :each | each key amountOfFutures ];
		column: 'Pending' text: [ :each | each key pendingQueueSize ];
		column: 'Busy' text: [ :each | each key isBusy ];
		column: 'Running' text: [ :each | each key isRunning ];
		send: [ :each | each key ];
		actionUpdateButton;
		actionButtonIcon: BrGlamorousVectorIcons signal
			tooltip: 'Enable telemetry'
			action: [ self telemetryDo: #yourself ifNone: [ self telemetry: (aTelemetry := AsyncFutureThreadPoolTelemetry new) ] ];
			actionButtonIcon: BrGlamorousVectorIcons cancel
		tooltip: 'Reset telemetry'
			action: [ self telemetryDo: #reset ]
]
