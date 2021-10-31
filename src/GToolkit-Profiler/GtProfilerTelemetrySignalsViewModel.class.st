Class {
	#name : #GtProfilerTelemetrySignalsViewModel,
	#superclass : #Object,
	#instVars : [
		'logger',
		'announcer',
		'parentProfilerTelemetryLoggerViewModel',
		'profilerTelemetrySignalViewModels'
	],
	#category : 'GToolkit-Profiler-Process - View Models'
}

{ #category : #'api - announcer' }
GtProfilerTelemetrySignalsViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentProfilerTelemetryLoggerViewModel
		ifTrue: [ self parentProfilerTelemetryLoggerViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtProfilerTelemetrySignalsViewModel >> createProfilerTelemetrySignalViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #GtProfilerTelemetrySignalViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self logger recordings collect: [ :eachModel |
		self createProfilerTelemetrySignalViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : #'private - instance creation' }
GtProfilerTelemetrySignalsViewModel >> createProfilerTelemetrySignalViewModelsFor: aChildModel [
	<return: #GtProfilerTelemetrySignalViewModel>
	<childObjectCreator: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := GtProfilerTelemetrySignalViewModel new.
	aNewChild parentProfilerTelemetrySignalsViewModel: self.
	aNewChild signal: aChildModel.
	^ aNewChild
]

{ #category : #'api - accessing' }
GtProfilerTelemetrySignalsViewModel >> findProfilerTelemetrySignalViewModels: aTelemetrySignal [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #GtProfilerTelemetrySignalViewModel or: nil>
	<childObjectDetector: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findProfilerTelemetrySignalViewModels: aTelemetrySignal
		ifFound: [ :aProfilerTelemetrySignalViewModels | aProfilerTelemetrySignalViewModels ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
GtProfilerTelemetrySignalsViewModel >> findProfilerTelemetrySignalViewModels: aTelemetrySignal ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self profilerTelemetrySignalViewModels
		detect: [ :eachProfilerTelemetrySignalViewModels |
			eachProfilerTelemetrySignalViewModels signal = aTelemetrySignal ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-extentions' }
GtProfilerTelemetrySignalsViewModel >> gtTelemetrySignalListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'TelemetrySignal';
		items: [ self profilerTelemetrySignalViewModels ]
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> hasLogger [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ logger notNil
]

{ #category : #'api - testing' }
GtProfilerTelemetrySignalsViewModel >> hasParentProfilerTelemetryLoggerViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentProfilerTelemetryLoggerViewModel notNil
]

{ #category : #'api - testing' }
GtProfilerTelemetrySignalsViewModel >> includesProfilerTelemetrySignalViewModels: aProfilerTelemetrySignalViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self profilerTelemetrySignalViewModels anySatisfy: [ :eachProfilerTelemetrySignalViewModels |
		eachProfilerTelemetrySignalViewModels == aProfilerTelemetrySignalViewModels ]
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> logger [
	"Return a not-null logger assigned to the receiver"
	<modelGetter: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ logger notNil ]
		description: [ 'logger should be initialized' ].

	^ logger
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> logger: aLogger [
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

{ #category : #'private - notifying' }
GtProfilerTelemetrySignalsViewModel >> notifyProfilerTelemetrySignalViewModelAdded: aProfilerTelemetrySignalViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (GtProfilerTelemetrySignalViewModelAddedAnnouncement new
		profilerTelemetrySignalViewModel: aProfilerTelemetrySignalViewModel) 
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> onLoggerChanged [
	"Is sent when a new logger is assigned to the receiver.
	Note: #onLoggerChanged is sent before #subscribeToLogger
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostLoggerChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> onPostLoggerChanged [
	"I am an optional hook method that is sent after #subscribeToLogger.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'private - event handling' }
GtProfilerTelemetrySignalsViewModel >> onProfilerTelemetrySignalAdded: aBlTelemetrySignal [
	"Is sent when a new TelemetrySignal is added to the model of the receiver due to
	the handled ${class:BlTelemetrySignal}$ announcement."
	<modelEventHandler: #telemetrySignal event: #BlTelemetrySignal>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createProfilerTelemetrySignalViewModelsFor: aBlTelemetrySignal signal.
	self profilerTelemetrySignalViewModels add: aNewChildObject.
	self onProfilerTelemetrySignalViewModelAdded: aNewChildObject
]

{ #category : #'api - adding' }
GtProfilerTelemetrySignalsViewModel >> onProfilerTelemetrySignalViewModelAdded: aProfilerTelemetrySignalViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aProfilerTelemetrySignalViewModel parentProfilerTelemetrySignalsViewModel: self.
	self notifyProfilerTelemetrySignalViewModelAdded: aProfilerTelemetrySignalViewModel.
]

{ #category : #'api - accessing' }
GtProfilerTelemetrySignalsViewModel >> parentProfilerTelemetryLoggerViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtProfilerTelemetryLoggerViewModel>
	<parentObjectGetter: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentProfilerTelemetryLoggerViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentProfilerTelemetryLoggerViewModel
]

{ #category : #'api - accessing' }
GtProfilerTelemetrySignalsViewModel >> parentProfilerTelemetryLoggerViewModel: aGtProfilerTelemetryLoggerViewModel [
	"Assign a parent object (${class:GtProfilerTelemetryLoggerViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtProfilerTelemetryLoggerViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentProfilerTelemetryLoggerViewModel := aGtProfilerTelemetryLoggerViewModel
]

{ #category : #printing }
GtProfilerTelemetrySignalsViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self logger
]

{ #category : #'api - accessing' }
GtProfilerTelemetrySignalsViewModel >> profilerTelemetrySignalViewModels [
	"Return a collection of objects (${class:GtProfilerTelemetrySignalViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #GtProfilerTelemetrySignalViewModel>
	<childObjectGetter: #telemetrySignal>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  profilerTelemetrySignalViewModels ifNil: [ profilerTelemetrySignalViewModels := self createProfilerTelemetrySignalViewModels ]
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> subscribeToLogger [
	"Is sent after a new logger is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromLogger if the receiver subscribes to them"
	<modelSubscriber: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self logger when: BlTelemetrySignal send: #onProfilerTelemetrySignalAdded: to: self.
]

{ #category : #'api - announcer' }
GtProfilerTelemetrySignalsViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - logger' }
GtProfilerTelemetrySignalsViewModel >> unsubscribeFromLogger [
	"Is sent before a new logger is assigned to the receiver.
	Objects that subscribe to logger are required to implement this method."
	<modelUnsubscriber: #logger>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self logger unsubscribe: self.
]

{ #category : #'api - announcer' }
GtProfilerTelemetrySignalsViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtProfilerTelemetrySignalsViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
