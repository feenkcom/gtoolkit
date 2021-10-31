Trait {
	#name : #TGtWithProfilerProcessTelemetriesModel,
	#instVars : [
		'profilerProcessTelemetriesModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> hasProfilerProcessTelemetriesModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ profilerProcessTelemetriesModel notNil
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> onPostProfilerProcessTelemetriesModelChanged [
	"I am an optional hook method that is sent after #subscribeToProfilerProcessTelemetriesModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> onProfilerProcessTelemetriesModelChanged [
	"Is sent when a new profilerProcessTelemetriesModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetriesModelChanged is sent before #subscribeToProfilerProcessTelemetriesModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetriesModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> profilerProcessTelemetriesModel [
	"Return a not-null profilerProcessTelemetriesModel assigned to the receiver"
	<modelGetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ profilerProcessTelemetriesModel notNil ]
		description: [ 'profilerProcessTelemetriesModel should be initialized' ].

	^ profilerProcessTelemetriesModel
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> profilerProcessTelemetriesModel: aProfilerProcessTelemetriesModel [
	"Set a not-null profilerProcessTelemetriesModel assigned to the receiver"
	<modelSetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aProfilerProcessTelemetriesModel notNil ]
		description: [ 'profilerProcessTelemetriesModel must not be nil' ].

	profilerProcessTelemetriesModel == aProfilerProcessTelemetriesModel
		ifTrue: [ ^ self ].

	profilerProcessTelemetriesModel ifNotNil: [ self unsubscribeFromProfilerProcessTelemetriesModel ].
	profilerProcessTelemetriesModel := aProfilerProcessTelemetriesModel.

	self onProfilerProcessTelemetriesModelChanged.
	self subscribeToProfilerProcessTelemetriesModel.
	self onPostProfilerProcessTelemetriesModelChanged
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> subscribeToProfilerProcessTelemetriesModel [
	"Is sent after a new profilerProcessTelemetriesModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetriesModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - profiler process telemetries model' }
TGtWithProfilerProcessTelemetriesModel >> unsubscribeFromProfilerProcessTelemetriesModel [
	"Is sent before a new profilerProcessTelemetriesModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetriesModel are required to implement this method."
	<modelUnsubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
