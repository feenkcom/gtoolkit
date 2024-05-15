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
			package: 'GToolkit-PharoMigrations';
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Pharo9-Debugger';
			package: 'GToolkit-Pharo9-Subscriptions' with: [ 
				spec requires: #('GToolkit-PharoMigrations')];
			package: 'GToolkit-Pharo9-Iceberg' with: [ 
				spec requires: #('GToolkit-PharoMigrations')];
			package: 'GToolkit-Pharo9' ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self 
		forPharo11AndPharo12: [ 
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
		
			RBInlineMethodFromComponentRefactoring  compile: 'inlineClass

	| imps |

	inlineClass ifNotNil: [ ^ inlineClass ].
	imps := ( self model allImplementorsOf: self inlineSelector ) asOrderedCollection.
	imps size = 1
		ifTrue: [ ^ inlineClass := imps first ].
	imps ifEmpty: [ self refactoringFailure: ''Nobody defines a method named '' , self inlineSelector ].
	inlineClass := self requestImplementorToInline: imps.
	inlineClass ifNil: [ self refactoringFailure: ''No implementor selected'' ].
	^ inlineClass' classified: 'transforming'.
	
	] 
		forPharo10: [
			#Ephemeron asClass classSide 
				compile: 'leJsonV4Name

	^ nil' classified: 'serialisation'].
]
