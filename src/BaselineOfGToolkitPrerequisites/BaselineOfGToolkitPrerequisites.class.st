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
BaselineOfGToolkitPrerequisites >> applyPatchForFT2Handle [
	self 
		forPharo12: [] 
		forPharo11: [
			FT2Handle class 
				compile: 'startUp: isImageStarting
	<gtPharoPatch: #Pharo11>'
			classified: 'startup']
		forPharo10: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForJob [
	self 
		forPharo12: [] 
		forPharo11AndPharo10: [ Job addSlot: #announcer ] 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForWeakArray [
	self 
		forPharo12: [] 
		forPharo11AndPharo10: [ 
			WeakArray
				addClassVarNamed: 'MournLoopProcess';
				addClassVarNamed: 'StopRequested';
				addClassVarNamed: 'StoppedSemaphore';
				initialize ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec preLoadDoIt: #preLoadGToolkitPrerequisites:.
		spec postLoadDoIt: #postLoadGToolkitPrerequisites:.
		spec
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Pharo9-Subscriptions' ;
			package: 'GToolkit-Pharo9-Iceberg' ;
			package: 'GToolkit-Pharo9' ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> postLoadGToolkitPrerequisites: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self applyPatchForJob.
	self applyPatchForWeakArray.
	self applyPatchForFT2Handle.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> preLoadGToolkitPrerequisites: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true. 
	
	
]
