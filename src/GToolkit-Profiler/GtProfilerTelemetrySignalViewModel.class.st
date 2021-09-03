Class {
	#name : 'GtProfilerTelemetrySignalViewModel',
	#superclass : 'Object',
	#instVars : [
		'signal',
		'announcer',
		'parentProfilerTelemetrySignalsViewModel'
	],
	#category : 'GToolkit-Profiler-Process - View Models'
}

{ #category : 'api - announcer' }
GtProfilerTelemetrySignalViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentProfilerTelemetrySignalsViewModel
		ifTrue: [ self parentProfilerTelemetrySignalsViewModel announce: anAnnouncement ].
]

{ #category : 'api - testing' }
GtProfilerTelemetrySignalViewModel >> hasParentProfilerTelemetrySignalsViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentProfilerTelemetrySignalsViewModel notNil
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> hasSignal [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #signal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ signal notNil
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> onPostSignalChanged [
	"I am an optional hook method that is sent after #subscribeToSignal.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> onSignalChanged [
	"Is sent when a new signal is assigned to the receiver.
	Note: #onSignalChanged is sent before #subscribeToSignal
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSignalChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'api - accessing' }
GtProfilerTelemetrySignalViewModel >> parentProfilerTelemetrySignalsViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtProfilerTelemetrySignalsViewModel>
	<parentObjectGetter: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentProfilerTelemetrySignalsViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentProfilerTelemetrySignalsViewModel
]

{ #category : 'api - accessing' }
GtProfilerTelemetrySignalViewModel >> parentProfilerTelemetrySignalsViewModel: aGtProfilerTelemetrySignalsViewModel [
	"Assign a parent object (${class:GtProfilerTelemetrySignalsViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtProfilerTelemetrySignalsViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentProfilerTelemetrySignalsViewModel := aGtProfilerTelemetrySignalsViewModel
]

{ #category : 'printing' }
GtProfilerTelemetrySignalViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self signal
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> signal [
	"Return a not-null signal assigned to the receiver"
	<modelGetter: #signal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ signal notNil ]
		description: [ 'signal should be initialized' ].

	^ signal
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> signal: aSignal [
	"Set a not-null signal assigned to the receiver"
	<modelSetter: #signal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSignal notNil ]
		description: [ 'signal must not be nil' ].

	signal == aSignal
		ifTrue: [ ^ self ].

	signal ifNotNil: [ self unsubscribeFromSignal ].
	signal := aSignal.

	self onSignalChanged.
	self subscribeToSignal.
	self onPostSignalChanged
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> subscribeToSignal [
	"Is sent after a new signal is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSignal if the receiver subscribes to them"
	<modelSubscriber: #signal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - announcer' }
GtProfilerTelemetrySignalViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'api - signal' }
GtProfilerTelemetrySignalViewModel >> unsubscribeFromSignal [
	"Is sent before a new signal is assigned to the receiver.
	Objects that subscribe to signal are required to implement this method."
	<modelUnsubscriber: #signal>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : 'api - announcer' }
GtProfilerTelemetrySignalViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : 'api - announcer' }
GtProfilerTelemetrySignalViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
