Class {
	#name : #GtProfilerProcessTelemetryViewModel,
	#superclass : #Object,
	#traits : 'TGtWithProfilerProcessTelemetryModel',
	#classTraits : 'TGtWithProfilerProcessTelemetryModel classTrait',
	#instVars : [
		'announcer',
		'parentProfilerProcessTelemetriesViewModel',
		'profilerTelemetryLoggerViewModel'
	],
	#category : 'GToolkit-Profiler-Process - View Models'
}

{ #category : #'api - announcer' }
GtProfilerProcessTelemetryViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentProfilerProcessTelemetriesViewModel
		ifTrue: [ self parentProfilerProcessTelemetriesViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtProfilerProcessTelemetryViewModel >> createProfilerTelemetryLoggerViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #GtProfilerTelemetryLoggerViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := GtProfilerTelemetryLoggerViewModel new.
	childObject parentProfilerProcessTelemetryViewModel: self.
	
	^ childObject
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
]

{ #category : #'api - accessing' }
GtProfilerProcessTelemetryViewModel >> displayLabel [
	^ self profilerProcessTelemetryModel telemetry name
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#hasOtherPropertyTesterTemplate'>

	^ false
]

{ #category : #'api - testing' }
GtProfilerProcessTelemetryViewModel >> hasParentProfilerProcessTelemetriesViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentProfilerProcessTelemetriesViewModel notNil
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> isOnlySelectedProcessTelemetry [
	"Return true if only this processTelemetry is selected and not any of the children"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#onlyPropertyStatusTesterTemplate'>

	^ self isSelectedProcessTelemetry and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> isRunning [
	^ self profilerProcessTelemetryModel isRunning
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> isSelectedProcessTelemetry [
	"Return true if this processTelemetry is selected"
	<return: #Boolean>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#propertyStatusTesterTemplate'>

	^ self parentProfilerProcessTelemetriesViewModel hasSelectedProcessTelemetryViewModel
		and: [ self parentProfilerProcessTelemetriesViewModel selectedProcessTelemetryViewModel == self ]
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> notifyProcessTelemetryDeselected [
	<propertyUnsetNotifier: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertyUnsetTemplate'>

	self announce: (GtProfilerProcessTelemetryViewModelDeselected new profilerProcessTelemetryViewModel: self)
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> notifyProcessTelemetrySelected [
	<propertySetNotifier: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#notifyPropertySetTemplate'>

	self announce: (GtProfilerProcessTelemetryViewModelSelected new profilerProcessTelemetryViewModel: self)
]

{ #category : #'private - event handling' }
GtProfilerProcessTelemetryViewModel >> onProcessTelemetryStarted [
	self announce: (GtProfilerProcessTelemetryViewModelStarted new profilerProcessTelemetryViewModel: self).
	self profilerTelemetryLoggerViewModel start
]

{ #category : #'private - event handling' }
GtProfilerProcessTelemetryViewModel >> onProcessTelemetryStopped [
	self announce: (GtProfilerProcessTelemetryViewModelStopped new profilerProcessTelemetryViewModel: self).
	self profilerTelemetryLoggerViewModel stop
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> onProfilerProcessTelemetryModelChanged [
	"Is sent when a new profilerProcessTelemetryModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetryModelChanged is sent before #subscribeToProfilerProcessTelemetryModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetryModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self profilerTelemetryLoggerViewModel stop.
	self profilerTelemetryLoggerViewModel
		logger: (BlTelemetryLogger new telemetryClass: self profilerProcessTelemetryModel telemetry).
		
	self profilerProcessTelemetryModel isRunning
		ifTrue: [ self profilerTelemetryLoggerViewModel start ].
]

{ #category : #'api - accessing' }
GtProfilerProcessTelemetryViewModel >> parentProfilerProcessTelemetriesViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtProfilerProcessTelemetriesViewModel>
	<parentObjectGetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentProfilerProcessTelemetriesViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentProfilerProcessTelemetriesViewModel
]

{ #category : #'api - accessing' }
GtProfilerProcessTelemetryViewModel >> parentProfilerProcessTelemetriesViewModel: aGtProfilerProcessTelemetriesViewModel [
	"Assign a parent object (${class:GtProfilerProcessTelemetriesViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #processTelemetries>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtProfilerProcessTelemetriesViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentProfilerProcessTelemetriesViewModel := aGtProfilerProcessTelemetriesViewModel
]

{ #category : #printing }
GtProfilerProcessTelemetryViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self profilerProcessTelemetryModel
]

{ #category : #'api - accessing' }
GtProfilerProcessTelemetryViewModel >> processTelemetryClass [
	^ self profilerProcessTelemetryModel telemetry
]

{ #category : #'api - accessing' }
GtProfilerProcessTelemetryViewModel >> profilerTelemetryLoggerViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #GtProfilerTelemetryLoggerViewModel>
	<childObjectGetter: #telemetryLogger>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ profilerTelemetryLoggerViewModel ifNil: [ profilerTelemetryLoggerViewModel := self createProfilerTelemetryLoggerViewModel ]
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> reset [
	self profilerTelemetryLoggerViewModel reset
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> selectProcessTelemetry [
	"Just select a processTelemetry without changing children"
	<propertySetter: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectTemplate'>
	
	self hasParentProfilerProcessTelemetriesViewModel
		ifTrue: [ self parentProfilerProcessTelemetriesViewModel selectProcessTelemetryViewModel: self ]
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> selectProcessTelemetryWithoutOtherEntities [
	"Select a processTelemetry and deselect other selected children"

	<generatedFrom: #'TGtRobocoderMetamodelPropertyForChildTemplate>>#setObjectWithoutOtherEntitiesTemplate'>
	self deselectAllFromTopMostParent.
	self selectProcessTelemetry
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> start [
	self profilerProcessTelemetryModel start
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> stop [
	self profilerProcessTelemetryModel stop
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> subscribeToProfilerProcessTelemetryModel [
	"Is sent after a new profilerProcessTelemetryModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetryModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self profilerProcessTelemetryModel
		when: GtProfilerProcessTelemetryModelStarted
			send: #onProcessTelemetryStarted
			to: self;
		when: GtProfilerProcessTelemetryModelStopped
			send: #onProcessTelemetryStopped
			to: self
]

{ #category : #'api - selection' }
GtProfilerProcessTelemetryViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	aCurrentParent := self.
	(aCurrentParent notNil and: [ aCurrentParent hasParentProfilerProcessTelemetriesViewModel ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent parentProfilerProcessTelemetriesViewModel ].
	
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWithSelectionDo: aBlock ].
	
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].
]

{ #category : #'api - announcer' }
GtProfilerProcessTelemetryViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - profiler process telemetry model' }
GtProfilerProcessTelemetryViewModel >> unsubscribeFromProfilerProcessTelemetryModel [
	"Is sent before a new profilerProcessTelemetryModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetryModel are required to implement this method."
	<modelUnsubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self profilerProcessTelemetryModel unsubscribe: self
]

{ #category : #'api - announcer' }
GtProfilerProcessTelemetryViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtProfilerProcessTelemetryViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
