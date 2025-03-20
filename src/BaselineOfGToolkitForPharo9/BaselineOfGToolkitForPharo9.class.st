Class {
	#name : #BaselineOfGToolkitForPharo9,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitForPharo9
}

{ #category : #baseline }
BaselineOfGToolkitForPharo9 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadGToolkit:'.
		spec
			baseline: 'GToolkitPrerequisites' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.1608/src' ].
		spec
			baseline: 'GToolkit' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.1608/src' ].

		spec package: 'GToolkit-PharoOverrides-Debugger' with: [
			spec requires: #(#GToolkitPrerequisites #GToolkit) ].
	]
]

{ #category : #accessing }
BaselineOfGToolkitForPharo9 >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

]
