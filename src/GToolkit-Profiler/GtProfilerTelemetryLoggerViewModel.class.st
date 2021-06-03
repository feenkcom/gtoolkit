Class {
	#name : #GtProfilerTelemetryLoggerViewModel,
	#superclass : #Object,
	#instVars : [
		'logger',
		'announcer',
		'parentProfilerProcessTelemetryViewModel',
		'profilerTelemetrySignalsViewModel'
	],
	#category : #'GToolkit-Profiler-Process - View Models'
}

{ #category : #'api - announcer' }
GtProfilerTelemetryLoggerViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentProfilerProcessTelemetryViewModel
		ifTrue: [ self parentProfilerProcessTelemetryViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtProfilerTelemetryLoggerViewModel >> createProfilerTelemetrySignalsViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #GtProfilerTelemetrySignalsViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := GtProfilerTelemetrySignalsViewModel new.
	childObject parentProfilerTelemetryLoggerViewModel: self.
	childObject logger: self logger yourself.
	^ childObject
]

{ #category : #'gt-extentions' }
GtProfilerTelemetryLoggerViewModel >> gtSignalsChartFor: aView [
	<gtView>
	<gtProfilerTelemetryLoggerView>
	
	^ aView explicit
		title: 'Chart';
		priority: 5;
		stencil: [
			GtProfilerTelemetrySignalsChartElement new
				profilerTelemetrySignalsViewModel: self profilerTelemetrySignalsViewModel ]
]

{ #category : #'gt-extentions' }
GtProfilerTelemetryLoggerViewModel >> gtSignalsFor: aView [
	<gtView>
	<gtProfilerTelemetryLoggerView>
	
	^ aView explicit
		title: 'Signals';
		priority: 10;
		stencil: [
			GtProfilerTelemetrySignalsElement new
				profilerTelemetrySignalsViewModel: self profilerTelemetrySignalsViewModel ]
]

{ #category : #'gt-extentions' }
GtProfilerTelemetryLoggerViewModel >> gtTelemetrySignalsListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'TelemetrySignals';
		items: [ self profilerTelemetrySignalsViewModel profilerTelemetrySignalViewModels ]
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> hasLogger [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ logger notNil
]

{ #category : #'api - testing' }
GtProfilerTelemetryLoggerViewModel >> hasParentProfilerProcessTelemetryViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentProfilerProcessTelemetryViewModel notNil
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> isRunning [
	^ self logger isRunning
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> logger [
	"Return a not-null logger assigned to the receiver"
	<modelGetter: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ logger notNil ]
		description: [ 'logger should be initialized' ].

	^ logger
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> logger: aLogger [
	"Set a not-null logger assigned to the receiver"
	<modelSetter: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aLogger notNil ]
		description: [ 'logger must not be nil' ].

	logger == aLogger
		ifTrue: [ ^ self ].

	logger ifNotNil: [ self unsubscribeFromLogger ].
	logger := aLogger.

	self onLoggerChanged.
	self subscribeToLogger.
	self onPostLoggerChanged
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> onLoggerChanged [
	"Is sent when a new logger is assigned to the receiver.
	Note: #onLoggerChanged is sent before #subscribeToLogger
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostLoggerChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self profilerTelemetrySignalsViewModel logger: self logger
]

{ #category : #'private - event handling' }
GtProfilerTelemetryLoggerViewModel >> onLoggerStarted [
	self announce: (GtProfilerTelemetryLoggerViewModelStarted new profilerTelemetryLoggerViewModel: self)
]

{ #category : #'private - event handling' }
GtProfilerTelemetryLoggerViewModel >> onLoggerStopped [
	self announce: (GtProfilerTelemetryLoggerViewModelStopped new profilerTelemetryLoggerViewModel: self)
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> onPostLoggerChanged [
	"I am an optional hook method that is sent after #subscribeToLogger.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - accessing' }
GtProfilerTelemetryLoggerViewModel >> parentProfilerProcessTelemetryViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtProfilerProcessTelemetryViewModel>
	<parentObjectGetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentProfilerProcessTelemetryViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentProfilerProcessTelemetryViewModel
]

{ #category : #'api - accessing' }
GtProfilerTelemetryLoggerViewModel >> parentProfilerProcessTelemetryViewModel: aGtProfilerProcessTelemetryViewModel [
	"Assign a parent object (${class:GtProfilerProcessTelemetryViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtProfilerProcessTelemetryViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentProfilerProcessTelemetryViewModel := aGtProfilerProcessTelemetryViewModel
]

{ #category : #printing }
GtProfilerTelemetryLoggerViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self logger
]

{ #category : #'api - accessing' }
GtProfilerTelemetryLoggerViewModel >> profilerTelemetrySignalsViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #GtProfilerTelemetrySignalsViewModel>
	<childObjectGetter: #telemetrySignals>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ profilerTelemetrySignalsViewModel ifNil: [ profilerTelemetrySignalsViewModel := self createProfilerTelemetrySignalsViewModel ]
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> reset [
	self hasLogger
		ifFalse: [ ^ self ].

	self logger reset
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> start [
	self hasLogger
		ifFalse: [ ^ self ].

	self logger start
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> stop [
	self hasLogger
		ifFalse: [ ^ self ].
		
	self logger stop
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> subscribeToLogger [
	"Is sent after a new logger is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromLogger if the receiver subscribes to them"
	<modelSubscriber: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self logger
		when: BlTelemetryLoggerStarted
			send: #onLoggerStarted
			to: self;
		when: BlTelemetryLoggerStopped
			send: #onLoggerStopped
			to: self
]

{ #category : #'api - announcer' }
GtProfilerTelemetryLoggerViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - logger' }
GtProfilerTelemetryLoggerViewModel >> unsubscribeFromLogger [
	"Is sent before a new logger is assigned to the receiver.
	Objects that subscribe to logger are required to implement this method."
	<modelUnsubscriber: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
GtProfilerTelemetryLoggerViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtProfilerTelemetryLoggerViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
