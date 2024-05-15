Class {
	#name : #BaselineOfGToolkitPrerequisites,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitPrerequisites
}

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
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
