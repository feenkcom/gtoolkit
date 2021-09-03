Class {
	#name : 'GtProfilerTelemetrySignalsElement',
	#superclass : 'BrSimpleTree',
	#traits : 'TGtWithProfilerTelemetrySignalsViewModel',
	#classTraits : 'TGtWithProfilerTelemetrySignalsViewModel classTrait',
	#instVars : [
		'updateRequester'
	],
	#category : 'GToolkit-Profiler-Process - Views'
}

{ #category : 'initialization' }
GtProfilerTelemetrySignalsElement >> initialize [
	super initialize.

	self nodeStencil: [
		BrLabel new
			hMatchParent;
			padding: (BlInsets all: 3);
			aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ].
	self nodeDataBinder: [ :eachElement :eachTelemetrySignalViewModel |
		eachElement
			text: eachTelemetrySignalViewModel signal task durationInMilliseconds asString, 'ms', ' ',eachTelemetrySignalViewModel signal task name  ].
	
	updateRequester := GtPhlowUpdateRequester new 
		element: self selector: #updateList.
]

{ #category : 'api - profiler telemetry signals view model' }
GtProfilerTelemetrySignalsElement >> onProfilerTelemetrySignalsViewModelChanged [
	"Is sent when a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Note: #onProfilerTelemetrySignalsViewModelChanged is sent before #subscribeToProfilerTelemetrySignalsViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetrySignalsViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self updateList
]

{ #category : 'private - event handling' }
GtProfilerTelemetrySignalsElement >> onTelemetrySignalAdded: aTelemetrySignalAddedAnnouncement [
	updateRequester requestUpdate
]

{ #category : 'api - profiler telemetry signals view model' }
GtProfilerTelemetrySignalsElement >> subscribeToProfilerTelemetrySignalsViewModel [
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
GtProfilerTelemetrySignalsElement >> unsubscribeFromProfilerTelemetrySignalsViewModel [
	"Is sent before a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Objects that subscribe to profilerTelemetrySignalsViewModel are required to implement this method."
	<modelUnsubscriber: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self profilerTelemetrySignalsViewModel unsubscribe: self
]

{ #category : 'private - updating' }
GtProfilerTelemetrySignalsElement >> updateList [
	self items: self profilerTelemetrySignalsViewModel profilerTelemetrySignalViewModels immediate: [ :eachNode | #() ]
]
