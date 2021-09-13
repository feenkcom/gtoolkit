Class {
	#name : 'GtProfilerProcessTelemetriesModel',
	#superclass : 'Object',
	#instVars : [
		'superProcessTelemetry',
		'announcer',
		'profilerProcessTelemetryModels'
	],
	#category : 'GToolkit-Profiler-Process - Models'
}

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesModel >> addProfilerProcessTelemetryModel: aProfilerProcessTelemetryModel [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesProfilerProcessTelemetryModels: aProfilerProcessTelemetryModel)
		ifTrue: [ ^ self ].
	
	
	self profilerProcessTelemetryModels add: aProfilerProcessTelemetryModel.
	self onProfilerProcessTelemetryModelAdded: aProfilerProcessTelemetryModel
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : 'private - instance creation' }
GtProfilerProcessTelemetriesModel >> createProfilerProcessTelemetryModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #GtProfilerProcessTelemetryModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self superProcessTelemetry allSubclasses collect: [ :eachModel |
		self createProfilerProcessTelemetryModelsFor: eachModel ] as: OrderedCollection
]

{ #category : 'private - instance creation' }
GtProfilerProcessTelemetriesModel >> createProfilerProcessTelemetryModelsFor: aChildModel [
	<return: #GtProfilerProcessTelemetryModel>
	<childObjectCreator: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := GtProfilerProcessTelemetryModel new.
	aNewChild parentProfilerProcessTelemetriesModel: self.
	aNewChild telemetry: aChildModel.
	^ aNewChild
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesModel >> findProfilerProcessTelemetryModels: aProcessTelemetry [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #GtProfilerProcessTelemetryModel or: nil>
	<childObjectDetector: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findProfilerProcessTelemetryModels: aProcessTelemetry
		ifFound: [ :aProfilerProcessTelemetryModels | aProfilerProcessTelemetryModels ]
		ifNone: [ nil ]
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesModel >> findProfilerProcessTelemetryModels: aProcessTelemetry ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self profilerProcessTelemetryModels
		detect: [ :eachProfilerProcessTelemetryModels |
			eachProfilerProcessTelemetryModels telemetry = aProcessTelemetry ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'gt-extentions' }
GtProfilerProcessTelemetriesModel >> gtProcessTelemetryListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'ProcessTelemetry';
		items: [ self profilerProcessTelemetryModels ]
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> hasSuperProcessTelemetry [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #superProcessTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ superProcessTelemetry notNil
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetriesModel >> includesProfilerProcessTelemetryModels: aProfilerProcessTelemetryModels [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self profilerProcessTelemetryModels anySatisfy: [ :eachProfilerProcessTelemetryModels |
		eachProfilerProcessTelemetryModels == aProfilerProcessTelemetryModels ]
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetriesModel >> isProfilerProcessTelemetriesModel [
	"Return true if the receiver represents profilerProcessTelemetriesModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ true
]

{ #category : 'api - testing' }
GtProfilerProcessTelemetriesModel >> isProfilerProcessTelemetryModel [
	"Return true if the receiver represents profilerProcessTelemetryModel, false otherwise"
	<return: #Boolean>
	<generatedFrom: #'GtRobocoderMetamodelTypeTestDerive>>#typeTesterTemplate'>

	^ false
]

{ #category : 'private - notifying' }
GtProfilerProcessTelemetriesModel >> notifyProfilerProcessTelemetryModelAdded: aProfilerProcessTelemetryModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (GtProfilerProcessTelemetryModelAddedAnnouncement new
		profilerProcessTelemetryModel: aProfilerProcessTelemetryModel) 
]

{ #category : 'private - notifying' }
GtProfilerProcessTelemetriesModel >> notifyProfilerProcessTelemetryModelRemoved: aProfilerProcessTelemetryModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (GtProfilerProcessTelemetryModelRemovedAnnouncement new
		profilerProcessTelemetryModel: aProfilerProcessTelemetryModel) 
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> onPostSuperProcessTelemetryChanged [
	"I am an optional hook method that is sent after #subscribeToSuperProcessTelemetry.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesModel >> onProfilerProcessTelemetryModelAdded: aProfilerProcessTelemetryModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aProfilerProcessTelemetryModel parentProfilerProcessTelemetriesModel: self.
	self notifyProfilerProcessTelemetryModelAdded: aProfilerProcessTelemetryModel.
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesModel >> onProfilerProcessTelemetryModelRemoved: aProfilerProcessTelemetryModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifyProfilerProcessTelemetryModelRemoved: aProfilerProcessTelemetryModel.
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> onSuperProcessTelemetryChanged [
	"Is sent when a new superProcessTelemetry is assigned to the receiver.
	Note: #onSuperProcessTelemetryChanged is sent before #subscribeToSuperProcessTelemetry
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSuperProcessTelemetryChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : 'printing' }
GtProfilerProcessTelemetriesModel >> printOn: aStream [
	<generatedFrom: #'GtRobocoderMetamodelPrintDerive>>#printOnTemplate'>
	aStream print: self superProcessTelemetry
]

{ #category : 'api - accessing' }
GtProfilerProcessTelemetriesModel >> profilerProcessTelemetryModels [
	"Return a collection of objects (${class:GtProfilerProcessTelemetryModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #GtProfilerProcessTelemetryModel>
	<childObjectGetter: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  profilerProcessTelemetryModels ifNil: [ profilerProcessTelemetryModels := self createProfilerProcessTelemetryModels ]
]

{ #category : 'api - adding' }
GtProfilerProcessTelemetriesModel >> removeProfilerProcessTelemetryModel: aProfilerProcessTelemetryModel [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #processTelemetry>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesProfilerProcessTelemetryModels: aProfilerProcessTelemetryModel)
		ifFalse: [ ^ self ].
	
	
	self profilerProcessTelemetryModels
		remove: aProfilerProcessTelemetryModel
		ifAbsent: [ ^ self ].
	self onProfilerProcessTelemetryModelRemoved: aProfilerProcessTelemetryModel
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> subscribeToSuperProcessTelemetry [
	"Is sent after a new superProcessTelemetry is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSuperProcessTelemetry if the receiver subscribes to them"
	<modelSubscriber: #superProcessTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> superProcessTelemetry [
	"Return a not-null superProcessTelemetry assigned to the receiver"
	<modelGetter: #superProcessTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ superProcessTelemetry notNil ]
		description: [ 'superProcessTelemetry should be initialized' ].

	^ superProcessTelemetry
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> superProcessTelemetry: aSuperProcessTelemetry [
	"Set a not-null superProcessTelemetry assigned to the receiver"
	<modelSetter: #superProcessTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSuperProcessTelemetry notNil ]
		description: [ 'superProcessTelemetry must not be nil' ].

	superProcessTelemetry == aSuperProcessTelemetry
		ifTrue: [ ^ self ].

	superProcessTelemetry ifNotNil: [ self unsubscribeFromSuperProcessTelemetry ].
	superProcessTelemetry := aSuperProcessTelemetry.

	self onSuperProcessTelemetryChanged.
	self subscribeToSuperProcessTelemetry.
	self onPostSuperProcessTelemetryChanged
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'api - super process telemetry' }
GtProfilerProcessTelemetriesModel >> unsubscribeFromSuperProcessTelemetry [
	"Is sent before a new superProcessTelemetry is assigned to the receiver.
	Objects that subscribe to superProcessTelemetry are required to implement this method."
	<modelUnsubscriber: #superProcessTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : 'api - announcer' }
GtProfilerProcessTelemetriesModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
