Trait {
	#name : 'TGtWithProfilerProcessTelemetryModel',
	#instVars : [
		'profilerProcessTelemetryModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> hasProfilerProcessTelemetryModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerProcessTelemetryModel notNil
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> onPostProfilerProcessTelemetryModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerProcessTelemetryModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> onProfilerProcessTelemetryModelChanged [
	"Is sent when a new profilerProcessTelemetryModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetryModelChanged is sent before #subscribeToProfilerProcessTelemetryModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetryModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> profilerProcessTelemetryModel [
	"Return a not-null profilerProcessTelemetryModel assigned to the receiver"
	<modelGetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerProcessTelemetryModel notNil ]
		description: [ 'profilerProcessTelemetryModel should be initialized' ].

	^ profilerProcessTelemetryModel
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> profilerProcessTelemetryModel: aProfilerProcessTelemetryModel [
	"Set a not-null profilerProcessTelemetryModel assigned to the receiver"
	<modelSetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerProcessTelemetryModel notNil ]
		description: [ 'profilerProcessTelemetryModel must not be nil' ].

	profilerProcessTelemetryModel == aProfilerProcessTelemetryModel
		ifTrue: [ ^ self ].

	profilerProcessTelemetryModel ifNotNil: [ self unsubscribeFromProfilerProcessTelemetryModel ].
	profilerProcessTelemetryModel := aProfilerProcessTelemetryModel.

	self onProfilerProcessTelemetryModelChanged.
	self subscribeToProfilerProcessTelemetryModel.
	self onPostProfilerProcessTelemetryModelChanged
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> subscribeToProfilerProcessTelemetryModel [
	"Is sent after a new profilerProcessTelemetryModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetryModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - profiler process telemetry model' }
TGtWithProfilerProcessTelemetryModel >> unsubscribeFromProfilerProcessTelemetryModel [
	"Is sent before a new profilerProcessTelemetryModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetryModel are required to implement this method."
	<modelUnsubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
