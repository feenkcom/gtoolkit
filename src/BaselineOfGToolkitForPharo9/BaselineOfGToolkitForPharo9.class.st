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
			baseline: 'GToolkit' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.338/src' ].

		spec package: 'GToolkit-Pharo9-Deprecations'.
		spec package: 'GToolkit-Pharo9-Debugger'.
		spec package: 'GToolkit-Pharo9-Subscriptions'.
		spec package: 'GToolkit-Pharo9-Iceberg'.
		spec package: 'GToolkit-PharoMigrations'.
		spec package: 'GToolkit-Pharo9' with: [
			spec requires: #('GToolkit-Pharo9-Deprecations' 'GToolkit-Pharo9-Debugger' 'GToolkit-Pharo9-Subscriptions' 'GToolkit-Pharo9-Iceberg' 'GToolkit') ].
	]
]

{ #category : #baselines }
BaselineOfGToolkitForPharo9 >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self 
		forPharo11: [ 
			#(#FinalizationRegistryEntry #WeakKeyAssociation) do: [ :aClassName | 
				aClassName asClass classSide 
					compile: 'leJsonV4Name

	^ nil' classified: 'serialisation' ]
		] 
		forPharo10: [
			#Ephemeron asClass classSide 
				compile: 'leJsonV4Name

	^ nil' classified: 'serialisation'].
]
