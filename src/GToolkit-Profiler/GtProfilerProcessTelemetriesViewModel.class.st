Class {
	#name : 'GtProfilerProcessTelemetriesViewModel',
	#superclass : 'Object',
	#traits : 'TGtWithProfilerProcessTelemetriesModel + TGtWithSelectedProcessTelemetryViewModel',
	#classTraits : 'TGtWithProfilerProcessTelemetriesModel classTrait + TGtWithSelectedProcessTelemetryViewModel classTrait',
	#instVars : [
		'announcer',
		'profilerProcessTelemetryViewModels'
	],
	#category : 'GToolkit-Profiler-Process - View Models'
}

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesViewModel >> addProfilerProcessTelemetryModel: aProfilerProcessTelemetry [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self profilerProcessTelemetriesModel addProfilerProcessTelemetryModel: aProfilerProcessTelemetry
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : 'private - instance creation' }
GtProfilerProcessTelemetriesViewModel >> createProfilerProcessTelemetryViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #GtProfilerProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self profilerProcessTelemetriesModel profilerProcessTelemetryModels collect: [ :eachModel |
		self createProfilerProcessTelemetryViewModelsFor: eachModel ] as: OrderedCollection
]

{ #category : 'private - instance creation' }
GtProfilerProcessTelemetriesViewModel >> createProfilerProcessTelemetryViewModelsFor: aChildModel [
	<return: #GtProfilerProcessTelemetryViewModel>
	<childObjectCreator: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := GtProfilerProcessTelemetryViewModel new.
	aNewChild parentProfilerProcessTelemetriesViewModel: self.
	aNewChild profilerProcessTelemetryModel: aChildModel.
	^ aNewChild
]

{ #category : 'api - selection' }
GtProfilerProcessTelemetriesViewModel >> deselectAllFromTopMostParent [
	"Deselect any selected child starting from the top most parent"
	<propertyUnsetFromParent: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetAllFromTopMostParentTemplate'>
	
	self topMostParentsWithSelectionDo: [ :eachParent | eachParent deselectChildren ]
]

{ #category : 'api - selection' }
GtProfilerProcessTelemetriesViewModel >> deselectChildren [
	"Deselect any selected child"
	<propertyUnsetChildren: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#unsetChildrenTemplate'>
	self deselectProcessTelemetryViewModel.
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesViewModel >> findProfilerProcessTelemetryViewModels: aProcessTelemetry [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #GtProfilerProcessTelemetryViewModel or: nil>
	<childObjectDetector: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findProfilerProcessTelemetryViewModels: aProcessTelemetry
		ifFound: [ :aProfilerProcessTelemetryViewModels | aProfilerProcessTelemetryViewModels ]
		ifNone: [ nil ]
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesViewModel >> findProfilerProcessTelemetryViewModels: aProcessTelemetry ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self profilerProcessTelemetryViewModels
		detect: [ :eachProfilerProcessTelemetryViewModels |
			eachProfilerProcessTelemetryViewModels profilerProcessTelemetryModel = aProcessTelemetry ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'gt-extentions' }
GtProfilerProcessTelemetriesViewModel >> gtProcessTelemetryListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'ProcessTelemetry';
		items: [ self profilerProcessTelemetryViewModels ]
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetriesViewModel >> includesProfilerProcessTelemetryViewModels: aProfilerProcessTelemetryViewModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self profilerProcessTelemetryViewModels anySatisfy: [ :eachProfilerProcessTelemetryViewModels |
		eachProfilerProcessTelemetryViewModels == aProfilerProcessTelemetryViewModels ]
]

{ #category : 'private - notifying' }
GtProfilerProcessTelemetriesViewModel >> notifyProfilerProcessTelemetryViewModelAdded: aProfilerProcessTelemetryViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (GtProfilerProcessTelemetryViewModelAddedAnnouncement new
		profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel) 
]

{ #category : 'private - notifying' }
GtProfilerProcessTelemetriesViewModel >> notifyProfilerProcessTelemetryViewModelRemoved: aProfilerProcessTelemetryViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (GtProfilerProcessTelemetryViewModelRemovedAnnouncement new
		profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel) 
]

{ #category : 'api - selected process telemetry view model' }
GtProfilerProcessTelemetriesViewModel >> onNewSelectedProcessTelemetryViewModelSet: aNewSelectedProcessTelemetryViewModel [
	"Is sent after a new value of the selectedProcessTelemetryViewModel is assigned"
	<propertySetHook: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>

	aNewSelectedProcessTelemetryViewModel notifyProcessTelemetrySelected
]

{ #category : 'api - selected process telemetry view model' }
GtProfilerProcessTelemetriesViewModel >> onPreviousSelectedProcessTelemetryViewModelUnset: aPreviousSelectedProcessTelemetryViewModel [
	"Is sent after a previous value of the selectedProcessTelemetryViewModel is de-assigned"
	<propertyUnsetHook: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>

	aPreviousSelectedProcessTelemetryViewModel deselectChildren.
	aPreviousSelectedProcessTelemetryViewModel notifyProcessTelemetryDeselected
]

{ #category : 'private - event handling' }
GtProfilerProcessTelemetriesViewModel >> onProfilerProcessTelemetryAdded: aGtProfilerProcessTelemetryModelAddedAnnouncement [
	"Is sent when a new ProcessTelemetry is added to the model of the receiver due to
	the handled ${class:GtProfilerProcessTelemetryModelAddedAnnouncement}$ announcement."
	<modelEventHandler: #processTelemetry event: #GtProfilerProcessTelemetryModelAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createProfilerProcessTelemetryViewModelsFor: aGtProfilerProcessTelemetryModelAddedAnnouncement profilerProcessTelemetryModel.
	self profilerProcessTelemetryViewModels add: aNewChildObject.
	self onProfilerProcessTelemetryViewModelAdded: aNewChildObject
]

{ #category : 'private - event handling' }
GtProfilerProcessTelemetriesViewModel >> onProfilerProcessTelemetryRemoved: aGtProfilerProcessTelemetryModelRemovedAnnouncement [
	"Is sent when an existing ProcessTelemetry is removed from the model of the receiver due to
	the handled ${class:GtProfilerProcessTelemetryModelRemovedAnnouncement}$ announcement."
	<modelEventHandler: #processTelemetry event: #GtProfilerProcessTelemetryModelRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findProfilerProcessTelemetryViewModels: aGtProfilerProcessTelemetryModelRemovedAnnouncement profilerProcessTelemetryModel)
		ifNil: [ ^ self ].

	self profilerProcessTelemetryViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onProfilerProcessTelemetryViewModelRemoved: aChildObject
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesViewModel >> onProfilerProcessTelemetryViewModelAdded: aProfilerProcessTelemetryViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aProfilerProcessTelemetryViewModel parentProfilerProcessTelemetriesViewModel: self.
	self notifyProfilerProcessTelemetryViewModelAdded: aProfilerProcessTelemetryViewModel.
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesViewModel >> onProfilerProcessTelemetryViewModelRemoved: aProfilerProcessTelemetryViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyProfilerProcessTelemetryViewModelRemoved: aProfilerProcessTelemetryViewModel.
]

{ #category : 'printing' }
GtProfilerProcessTelemetriesViewModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self profilerProcessTelemetriesModel
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesViewModel >> profilerProcessTelemetryViewModels [
	"Return a collection of objects (${class:GtProfilerProcessTelemetryViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #GtProfilerProcessTelemetryViewModel>
	<childObjectGetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  profilerProcessTelemetryViewModels ifNil: [ profilerProcessTelemetryViewModels := self createProfilerProcessTelemetryViewModels ]
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesViewModel >> removeProfilerProcessTelemetryModel: aProfilerProcessTelemetry [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self profilerProcessTelemetriesModel removeProfilerProcessTelemetryModel: aProfilerProcessTelemetry
]

{ #category : 'api - profiler process telemetries model' }
GtProfilerProcessTelemetriesViewModel >> subscribeToProfilerProcessTelemetriesModel [
	"Is sent after a new profilerProcessTelemetriesModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetriesModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	self profilerProcessTelemetriesModel when: GtProfilerProcessTelemetryModelAddedAnnouncement send: #onProfilerProcessTelemetryAdded: to: self.
	self profilerProcessTelemetriesModel when: GtProfilerProcessTelemetryModelRemovedAnnouncement send: #onProfilerProcessTelemetryRemoved: to: self.
]

{ #category : 'api - selection' }
GtProfilerProcessTelemetriesViewModel >> topMostParentsWithSelectionDo: aBlock [
	"Evaluate a given block with each top most parent that has a selection property"
	<propertyTopMostParents: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyForParentTemplate>>#topMostParentsWithPropertyDoTemplate'>
	
	aBlock value: self.
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'api - profiler process telemetries model' }
GtProfilerProcessTelemetriesViewModel >> unsubscribeFromProfilerProcessTelemetriesModel [
	"Is sent before a new profilerProcessTelemetriesModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetriesModel are required to implement this method."
	<modelUnsubscriber: #processTelemetries>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	self profilerProcessTelemetriesModel unsubscribe: self.
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
