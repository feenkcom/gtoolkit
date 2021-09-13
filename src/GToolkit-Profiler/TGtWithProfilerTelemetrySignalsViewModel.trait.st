Trait {
	#name : 'TGtWithProfilerTelemetrySignalsViewModel',
	#instVars : [
		'profilerTelemetrySignalsViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> hasProfilerTelemetrySignalsViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerTelemetrySignalsViewModel notNil
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> onPostProfilerTelemetrySignalsViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerTelemetrySignalsViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> onProfilerTelemetrySignalsViewModelChanged [
	"Is sent when a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Note: #onProfilerTelemetrySignalsViewModelChanged is sent before #subscribeToProfilerTelemetrySignalsViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetrySignalsViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> profilerTelemetrySignalsViewModel [
	"Return a not-null profilerTelemetrySignalsViewModel assigned to the receiver"
	<modelGetter: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerTelemetrySignalsViewModel notNil ]
		description: [ 'profilerTelemetrySignalsViewModel should be initialized' ].

	^ profilerTelemetrySignalsViewModel
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> profilerTelemetrySignalsViewModel: aProfilerTelemetrySignalsViewModel [
	"Set a not-null profilerTelemetrySignalsViewModel assigned to the receiver"
	<modelSetter: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerTelemetrySignalsViewModel notNil ]
		description: [ 'profilerTelemetrySignalsViewModel must not be nil' ].

	profilerTelemetrySignalsViewModel == aProfilerTelemetrySignalsViewModel
		ifTrue: [ ^ self ].

	profilerTelemetrySignalsViewModel ifNotNil: [ self unsubscribeFromProfilerTelemetrySignalsViewModel ].
	profilerTelemetrySignalsViewModel := aProfilerTelemetrySignalsViewModel.

	self onProfilerTelemetrySignalsViewModelChanged.
	self subscribeToProfilerTelemetrySignalsViewModel.
	self onPostProfilerTelemetrySignalsViewModelChanged
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> subscribeToProfilerTelemetrySignalsViewModel [
	"Is sent after a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerTelemetrySignalsViewModel if the receiver subscribes to them"
	<modelSubscriber: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - profiler telemetry signals view model' }
TGtWithProfilerTelemetrySignalsViewModel >> unsubscribeFromProfilerTelemetrySignalsViewModel [
	"Is sent before a new profilerTelemetrySignalsViewModel is assigned to the receiver.
	Objects that subscribe to profilerTelemetrySignalsViewModel are required to implement this method."
	<modelUnsubscriber: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
