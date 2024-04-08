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
			baseline: 'GToolkit'
			with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ].
		spec
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Pharo9-Debugger';
			package: 'GToolkit-Pharo9-Subscriptions';
			package: 'GToolkit-Pharo9-Iceberg';
			package: 'GToolkit-PharoMigrations';
			package: 'GToolkit-Pharo9' with: [ 
				spec requires:
						#( 'GToolkit-Pharo9-Deprecations' 'GToolkit-Pharo9-Debugger'
						   'GToolkit-Pharo9-Subscriptions'
						   'GToolkit-Pharo9-Iceberg' 'GToolkit' ) ] ]
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

	^ nil' classified: 'serialisation' ].
			
			RBInlineMethodRefactoring addSlot: #inlineClass.
			RBInlineMethodRefactoring compile: 'inlineClass

	^ inlineClass
		ifNil: [ inlineClass := ( sourceMessage receiver name = ''super''
				ifTrue: [ class superclass ]
				ifFalse: [ class ] ) whoDefinesMethod: self inlineSelector
			]
		ifNotNil: [ inlineClass ]' classified: 'transforming'.
	
	] 
		forPharo10: [
			#Ephemeron asClass classSide 
				compile: 'leJsonV4Name

	^ nil' classified: 'serialisation'].
]
