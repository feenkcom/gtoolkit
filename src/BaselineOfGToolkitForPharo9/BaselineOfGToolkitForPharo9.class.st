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
				spec repository: 'github://feenkcom/gtoolkit:v1.0.780/src' ].
		spec
			baseline: 'GToolkit' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.780/src' ].

		spec package: 'GToolkit-PharoOverrides-Debugger' with: [
			spec requires: #('GToolkitPrerequisites' 'GToolkit') ].
	]
]

{ #category : #accessing }
BaselineOfGToolkitForPharo9 >> patchInlineMethodRefactoring [
	
	self 
		forPharo11AndPharo12: [ 
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
	^ inlineClass' classified: 'transforming'. ] 
		forPharo10: [].
]

{ #category : #accessing }
BaselineOfGToolkitForPharo9 >> patchLeJsonV4Name [
	self 
		forPharo11AndPharo12: [ 
			#(#FinalizationRegistryEntry #WeakKeyAssociation) do: [ :aClassName | 
				aClassName asClass classSide 
					compile: 'leJsonV4Name

	^ nil' classified: 'serialisation' ] 
	]
		forPharo10: [
			#Ephemeron asClass classSide 
				compile: 'leJsonV4Name

	^ nil' classified: 'serialisation'
	].
]

{ #category : #accessing }
BaselineOfGToolkitForPharo9 >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self patchLeJsonV4Name.
	self patchInlineMethodRefactoring.
]
