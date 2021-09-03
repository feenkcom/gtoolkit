Class {
	#name : 'GtProfilerProcessTelemetryModel',
	#superclass : 'Object',
	#instVars : [
		'telemetry',
		'announcer',
		'parentProfilerProcessTelemetriesModel'
	],
	#category : 'GToolkit-Profiler-Process - Models'
}

{ #category : 'api - announcer' }
GtProfilerProcessTelemetryModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentProfilerProcessTelemetriesModel
		ifTrue: [ self parentProfilerProcessTelemetriesModel announce: anAnnouncement ].
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetryModel >> hasParentProfilerProcessTelemetriesModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentProfilerProcessTelemetriesModel notNil
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> hasTelemetry [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #telemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ telemetry notNil
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetryModel >> isProfilerProcessTelemetriesModel [
	"Return true if the receiver represents profilerProcessTelemetriesModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetryModel >> isProfilerProcessTelemetryModel [
	"Return true if the receiver represents profilerProcessTelemetryModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> isRunning [
	^ self telemetry defaultTelemetryClass = BlMemoryTelemetry
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> onPostTelemetryChanged [
	"I am an optional hook method that is sent after #subscribeToTelemetry.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> onTelemetryChanged [
	"Is sent when a new telemetry is assigned to the receiver.
	Note: #onTelemetryChanged is sent before #subscribeToTelemetry
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTelemetryChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetryModel >> parentProfilerProcessTelemetriesModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtProfilerProcessTelemetriesModel>
	<parentObjectGetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentProfilerProcessTelemetriesModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentProfilerProcessTelemetriesModel
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetryModel >> parentProfilerProcessTelemetriesModel: aGtProfilerProcessTelemetriesModel [
	"Assign a parent object (${class:GtProfilerProcessTelemetriesModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtProfilerProcessTelemetriesModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentProfilerProcessTelemetriesModel := aGtProfilerProcessTelemetriesModel
]

{ #category : 'printing' }
GtProfilerProcessTelemetryModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self telemetry
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> start [
	self telemetry defaultTelemetryClass: BlMemoryTelemetry.
	self announce: (GtProfilerProcessTelemetryModelStarted new profilerProcessTelemetryModel: self)
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> stop [
	self telemetry defaultTelemetryClass: BlNullTelemetry.
	self announce: (GtProfilerProcessTelemetryModelStopped new profilerProcessTelemetryModel: self)
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> subscribeToTelemetry [
	"Is sent after a new telemetry is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromTelemetry if the receiver subscribes to them"
	<modelSubscriber: #telemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> telemetry [
	"Return a not-null telemetry assigned to the receiver"
	<modelGetter: #telemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ telemetry notNil ]
		description: [ 'telemetry should be initialized' ].

	^ telemetry
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> telemetry: aTelemetry [
	"Set a not-null telemetry assigned to the receiver"
	<modelSetter: #telemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aTelemetry notNil ]
		description: [ 'telemetry must not be nil' ].

	telemetry == aTelemetry
		ifTrue: [ ^ self ].

	telemetry ifNotNil: [ self unsubscribeFromTelemetry ].
	telemetry := aTelemetry.

	self onTelemetryChanged.
	self subscribeToTelemetry.
	self onPostTelemetryChanged
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetryModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'api - telemetry' }
GtProfilerProcessTelemetryModel >> unsubscribeFromTelemetry [
	"Is sent before a new telemetry is assigned to the receiver.
	Objects that subscribe to telemetry are required to implement this method."
	<modelUnsubscriber: #telemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetryModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetryModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
