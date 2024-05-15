Class {
	#name : #BaselineOfGToolkitPrerequisites,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded',
		'PreLoaded'
	],
	#category : #BaselineOfGToolkitPrerequisites
}

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec preLoadDoIt: #preLoadGToolkit:.
		spec postLoadDoIt: #postLoadGToolkit:.
		spec
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Pharo9-Subscriptions' ;
			package: 'GToolkit-Pharo9-Iceberg' ;
			package: 'GToolkit-Pharo9' ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	WeakArray
		addClassVarNamed: 'MournLoopProcess';
		addClassVarNamed: 'StopRequested';
		addClassVarNamed: 'StoppedSemaphore';
		initialize.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> preLoadGToolkit: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true. 
	
	self 
		forPharo12: [] 
		forPharo11: [ Job addSlot: #announcer ] 
		forPharo10: [ Job addSlot: #announcer ]
]
