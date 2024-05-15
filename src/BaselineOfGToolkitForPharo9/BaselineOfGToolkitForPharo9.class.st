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
		spec
			baseline: 'GToolkitPrerequisites'
			with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ].
		spec
			baseline: 'GToolkit'
			with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ] ]
]
