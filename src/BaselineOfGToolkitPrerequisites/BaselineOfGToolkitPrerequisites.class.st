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
BaselineOfGToolkitPrerequisites >> applyPatchForLeJsonV4Name [
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
BaselineOfGToolkitPrerequisites >> applyPatchInlineMethodRefactoring [
	
	self 
		forPharo11AndPharo12: [ 
			RBInlineMethodRefactoring addSlot: #inlineClass.
			RBInlineMethodRefactoring compile: 'inlineClass
	<gtPharoPatch: #Pharo11Pharo12>
			
	^ inlineClass
		ifNil: [ inlineClass := ( sourceMessage receiver name = ''super''
				ifTrue: [ class superclass ]
				ifFalse: [ class ] ) whoDefinesMethod: self inlineSelector
			]
		ifNotNil: [ inlineClass ]' classified: 'transforming'.
		
			RBInlineMethodFromComponentRefactoring  compile: 'inlineClass
	<gtPharoPatch: #Pharo11Pharo12>

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
	self applyPatchForLeJsonV4Name.
	self applyPatchInlineMethodRefactoring.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> preLoadGToolkitPrerequisites: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true. 
	
	
]
