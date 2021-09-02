Trait {
	#name : 'TGtWithProfilerTelemetrySignalViewModel',
	#instVars : [
		'profilerTelemetrySignalViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> hasProfilerTelemetrySignalViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerTelemetrySignalViewModel notNil
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> onPostProfilerTelemetrySignalViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerTelemetrySignalViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> onProfilerTelemetrySignalViewModelChanged [
	"Is sent when a new profilerTelemetrySignalViewModel is assigned to the receiver.
	Note: #onProfilerTelemetrySignalViewModelChanged is sent before #subscribeToProfilerTelemetrySignalViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetrySignalViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> profilerTelemetrySignalViewModel [
	"Return a not-null profilerTelemetrySignalViewModel assigned to the receiver"
	<modelGetter: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerTelemetrySignalViewModel notNil ]
		description: [ 'profilerTelemetrySignalViewModel should be initialized' ].

	^ profilerTelemetrySignalViewModel
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> profilerTelemetrySignalViewModel: aProfilerTelemetrySignalViewModel [
	"Set a not-null profilerTelemetrySignalViewModel assigned to the receiver"
	<modelSetter: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerTelemetrySignalViewModel notNil ]
		description: [ 'profilerTelemetrySignalViewModel must not be nil' ].

	profilerTelemetrySignalViewModel == aProfilerTelemetrySignalViewModel
		ifTrue: [ ^ self ].

	profilerTelemetrySignalViewModel ifNotNil: [ self unsubscribeFromProfilerTelemetrySignalViewModel ].
	profilerTelemetrySignalViewModel := aProfilerTelemetrySignalViewModel.

	self onProfilerTelemetrySignalViewModelChanged.
	self subscribeToProfilerTelemetrySignalViewModel.
	self onPostProfilerTelemetrySignalViewModelChanged
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> subscribeToProfilerTelemetrySignalViewModel [
	"Is sent after a new profilerTelemetrySignalViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerTelemetrySignalViewModel if the receiver subscribes to them"
	<modelSubscriber: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - profiler telemetry signal view model' }
TGtWithProfilerTelemetrySignalViewModel >> unsubscribeFromProfilerTelemetrySignalViewModel [
	"Is sent before a new profilerTelemetrySignalViewModel is assigned to the receiver.
	Objects that subscribe to profilerTelemetrySignalViewModel are required to implement this method."
	<modelUnsubscriber: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
