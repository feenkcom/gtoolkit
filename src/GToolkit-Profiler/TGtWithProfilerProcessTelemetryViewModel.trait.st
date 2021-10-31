Trait {
	#name : #TGtWithProfilerProcessTelemetryViewModel,
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> hasProfilerProcessTelemetryViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerProcessTelemetryViewModel notNil
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> onPostProfilerProcessTelemetryViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerProcessTelemetryViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> onProfilerProcessTelemetryViewModelChanged [
	"Is sent when a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetryViewModelChanged is sent before #subscribeToProfilerProcessTelemetryViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetryViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> profilerProcessTelemetryViewModel [
	"Return a not-null profilerProcessTelemetryViewModel assigned to the receiver"
	<modelGetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerProcessTelemetryViewModel notNil ]
		description: [ 'profilerProcessTelemetryViewModel should be initialized' ].

	^ profilerProcessTelemetryViewModel
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	"Set a not-null profilerProcessTelemetryViewModel assigned to the receiver"
	<modelSetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerProcessTelemetryViewModel notNil ]
		description: [ 'profilerProcessTelemetryViewModel must not be nil' ].

	profilerProcessTelemetryViewModel == aProfilerProcessTelemetryViewModel
		ifTrue: [ ^ self ].

	profilerProcessTelemetryViewModel ifNotNil: [ self unsubscribeFromProfilerProcessTelemetryViewModel ].
	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel.

	self onProfilerProcessTelemetryViewModelChanged.
	self subscribeToProfilerProcessTelemetryViewModel.
	self onPostProfilerProcessTelemetryViewModelChanged
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> subscribeToProfilerProcessTelemetryViewModel [
	"Is sent after a new profilerProcessTelemetryViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetryViewModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - profiler process telemetry view model' }
TGtWithProfilerProcessTelemetryViewModel >> unsubscribeFromProfilerProcessTelemetryViewModel [
	"Is sent before a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetryViewModel are required to implement this method."
	<modelUnsubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
