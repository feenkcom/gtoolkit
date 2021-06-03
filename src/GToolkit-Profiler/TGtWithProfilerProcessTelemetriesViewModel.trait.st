Trait {
	#name : #TGtWithProfilerProcessTelemetriesViewModel,
	#instVars : [
		'profilerProcessTelemetriesViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Support'
}

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> hasProfilerProcessTelemetriesViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerProcessTelemetriesViewModel notNil
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> onPostProfilerProcessTelemetriesViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerProcessTelemetriesViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> onProfilerProcessTelemetriesViewModelChanged [
	"Is sent when a new profilerProcessTelemetriesViewModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetriesViewModelChanged is sent before #subscribeToProfilerProcessTelemetriesViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetriesViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> profilerProcessTelemetriesViewModel [
	"Return a not-null profilerProcessTelemetriesViewModel assigned to the receiver"
	<modelGetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerProcessTelemetriesViewModel notNil ]
		description: [ 'profilerProcessTelemetriesViewModel should be initialized' ].

	^ profilerProcessTelemetriesViewModel
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> profilerProcessTelemetriesViewModel: aProfilerProcessTelemetriesViewModel [
	"Set a not-null profilerProcessTelemetriesViewModel assigned to the receiver"
	<modelSetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerProcessTelemetriesViewModel notNil ]
		description: [ 'profilerProcessTelemetriesViewModel must not be nil' ].

	profilerProcessTelemetriesViewModel == aProfilerProcessTelemetriesViewModel
		ifTrue: [ ^ self ].

	profilerProcessTelemetriesViewModel ifNotNil: [ self unsubscribeFromProfilerProcessTelemetriesViewModel ].
	profilerProcessTelemetriesViewModel := aProfilerProcessTelemetriesViewModel.

	self onProfilerProcessTelemetriesViewModelChanged.
	self subscribeToProfilerProcessTelemetriesViewModel.
	self onPostProfilerProcessTelemetriesViewModelChanged
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> subscribeToProfilerProcessTelemetriesViewModel [
	"Is sent after a new profilerProcessTelemetriesViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetriesViewModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - profiler process telemetries view model' }
TGtWithProfilerProcessTelemetriesViewModel >> unsubscribeFromProfilerProcessTelemetriesViewModel [
	"Is sent before a new profilerProcessTelemetriesViewModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetriesViewModel are required to implement this method."
	<modelUnsubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
