Trait {
	#name : 'TGtWithProfilerTelemetryLoggerViewModel',
	#instVars : [
		'profilerTelemetryLoggerViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> hasProfilerTelemetryLoggerViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerTelemetryLoggerViewModel notNil
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> onPostProfilerTelemetryLoggerViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerTelemetryLoggerViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> onProfilerTelemetryLoggerViewModelChanged [
	"Is sent when a new profilerTelemetryLoggerViewModel is assigned to the receiver.
	Note: #onProfilerTelemetryLoggerViewModelChanged is sent before #subscribeToProfilerTelemetryLoggerViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetryLoggerViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> profilerTelemetryLoggerViewModel [
	"Return a not-null profilerTelemetryLoggerViewModel assigned to the receiver"
	<modelGetter: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerTelemetryLoggerViewModel notNil ]
		description: [ 'profilerTelemetryLoggerViewModel should be initialized' ].

	^ profilerTelemetryLoggerViewModel
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> profilerTelemetryLoggerViewModel: aProfilerTelemetryLoggerViewModel [
	"Set a not-null profilerTelemetryLoggerViewModel assigned to the receiver"
	<modelSetter: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerTelemetryLoggerViewModel notNil ]
		description: [ 'profilerTelemetryLoggerViewModel must not be nil' ].

	profilerTelemetryLoggerViewModel == aProfilerTelemetryLoggerViewModel
		ifTrue: [ ^ self ].

	profilerTelemetryLoggerViewModel ifNotNil: [ self unsubscribeFromProfilerTelemetryLoggerViewModel ].
	profilerTelemetryLoggerViewModel := aProfilerTelemetryLoggerViewModel.

	self onProfilerTelemetryLoggerViewModelChanged.
	self subscribeToProfilerTelemetryLoggerViewModel.
	self onPostProfilerTelemetryLoggerViewModelChanged
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> subscribeToProfilerTelemetryLoggerViewModel [
	"Is sent after a new profilerTelemetryLoggerViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerTelemetryLoggerViewModel if the receiver subscribes to them"
	<modelSubscriber: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - profiler telemetry logger view model' }
TGtWithProfilerTelemetryLoggerViewModel >> unsubscribeFromProfilerTelemetryLoggerViewModel [
	"Is sent before a new profilerTelemetryLoggerViewModel is assigned to the receiver.
	Objects that subscribe to profilerTelemetryLoggerViewModel are required to implement this method."
	<modelUnsubscriber: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
