Class {
	#name : #BaselineOfGToolkitForPharo9,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitForPharo9
}

{ #category : #baselines }
BaselineOfGToolkitForPharo9 >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec postLoadDoIt: #postLoadGToolkit:.
		spec
			baseline: 'GToolkitPrerequisites'
			with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ].
		spec
			baseline: 'GToolkit'
			with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ].
			
		spec
			package: 'GToolkit-PharoOverrides-Debugger' with: [
				spec requires: #('GToolkitPrerequisites' 'GToolkit')] ]
]

{ #category : #accessing }
BaselineOfGToolkitForPharo9 >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

]
