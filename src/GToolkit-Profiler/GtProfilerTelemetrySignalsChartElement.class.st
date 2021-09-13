Class {
	#name : 'GtProfilerTelemetrySignalsChartElement',
	#superclass : 'BrVerticalPane',
	#traits : 'TGtWithProfilerTelemetrySignalsViewModel',
	#classTraits : 'TGtWithProfilerTelemetrySignalsViewModel classTrait',
	#instVars : [
		'updateRequester'
	],
	#category : 'GToolkit-Profiler-Process - Views'
}

{ #category : 'initialization' }
GtProfilerTelemetrySignalsChartElement >> initialize [
	super initialize.
	
	self matchParent.
	self alignTopCenter.
	self padding: (BlInsets all: 10).
	
	updateRequester := GtPhlowUpdateRequester new 
		element: self selector: #updateChart.
]

{ #category : 'api - profiler telemetry signals view model' }
GtProfilerTelemetrySignalsChartElement >> onProfilerTelemetrySignalsViewModelChanged [
	"Is sent when a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Note: #onProfilerTelemetrySignalsViewModelChanged is sent before #subscribeToProfilerTelemetrySignalsViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetrySignalsViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self updateChart
]

{ #category : 'private - event handling' }
GtProfilerTelemetrySignalsChartElement >> onTelemetrySignalAdded: aTelemetrySignalAddedAnnouncement [
	updateRequester requestUpdate
]

{ #category : 'api - profiler telemetry signals view model' }
GtProfilerTelemetrySignalsChartElement >> subscribeToProfilerTelemetrySignalsViewModel [
	"Is sent after a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerTelemetrySignalsViewModel if the receiver subscribes to them"
	<modelSubscriber: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self profilerTelemetrySignalsViewModel
		when: GtProfilerTelemetrySignalViewModelAddedAnnouncement
		send: #onTelemetrySignalAdded:
		to: self
]

{ #category : 'api - profiler telemetry signals view model' }
GtProfilerTelemetrySignalsChartElement >> unsubscribeFromProfilerTelemetrySignalsViewModel [
	"Is sent before a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Objects that subscribe to profilerTelemetrySignalsViewModel are required to implement this method."
	<modelUnsubscriber: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self profilerTelemetrySignalsViewModel unsubscribe: self
]

{ #category : 'private - updating' }
GtProfilerTelemetrySignalsChartElement >> updateChart [
	| aData theRecordings anIndexMap aBarChart |
	
	self removeChildren.
	
	theRecordings := self profilerTelemetrySignalsViewModel profilerTelemetrySignalViewModels collect: [ :eachSignalViewModel |
		eachSignalViewModel signal ].
	
	anIndexMap := (theRecordings collectWithIndex: [ :eachSignal :eachIndex | eachSignal task -> eachIndex ]) asDictionary.
	
	aData := GtPlotterDataGroup new values: (theRecordings collect: [ :eachSignal | eachSignal task ]).
	aData := aData labelled: [ :eachTask | (anIndexMap at: eachTask) asString ].
	aData := aData colored: [ :eachTask |
		eachTask durationInMilliseconds <= 16
			ifTrue: [ BrGlamorousColors primaryBorderColor ]
			ifFalse: [ BrGlamorousColors errorBorderColor ] ].
	
	aBarChart := GtPlotter new horizontalBarChart
		with: aData;
		barGap: 0;
		groupSpacing: 0;
		barLabelWidth: 40;
		barWidthData: [ :eachTask | eachTask durationInMilliseconds ];
		barWidthScale: (GtPlotterLinearScale new domainFrom: 0 to: 100.0);
		barHeightScale: (GtPlotterConstantScale new constant: 8);
		tickLabelFormat: [ :eachDuration | eachDuration asString, ' ms' ];
		barElement: [ :aGtPlotterScaleContext |
			| aTaskDuration aGcPart |
			
			aTaskDuration := aGtPlotterScaleContext originalValue durationInMilliseconds.
			aGcPart := aTaskDuration isZero
				ifTrue: [ 0 ]
				ifFalse: [ (aGtPlotterScaleContext originalValue gcDurationInMilliseconds / aTaskDuration) asFloat ].
			
			BlElement new
				addChild: (BlElement new
					background: Color black;
					constraintsDo: [ :c |
						c ignoreByLayout.
						c vertical exact: 2.
						c horizontal matchParent.
						c ignored horizontal weight: aGcPart.
						c ignored vertical alignCenter
					]
				) ];
		asElement.
		
	aBarChart
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: BrSimpleList ]
		ifFound: [ :aList | aList scrollToIndex: aList items size ].

	self addChild: aBarChart
]
