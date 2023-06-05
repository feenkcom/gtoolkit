Class {
	#name : #BaselineOfGToolkitForPharo9,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitForPharo9
}

{ #category : #baselines }
BaselineOfGToolkitForPharo9 >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitWorld'
			with: [ spec repository: 'github://feenkcom/gtoolkit-world:main/src' ].
		spec
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Pharo9-Debugger';
			package: 'GToolkit-Pharo9-Subscriptions';
			package: 'GToolkit-Pharo9-Iceberg';
			package: 'GToolkit-Pharo9' with: [ 
				spec requires:
						#( 'GToolkit-Pharo9-Deprecations' 'GToolkit-Pharo9-Debugger'
						   'GToolkit-Pharo9-Subscriptions'
						   'GToolkit-Pharo9-Iceberg' 'GToolkitWorld' ) ] ]
]
