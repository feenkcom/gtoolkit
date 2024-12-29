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
BaselineOfGToolkitPrerequisites class >> apply: compileBlock toVersions: aCollection [ 

	(aCollection includes: SystemVersion current major) ifFalse: [ ^ self ].
	^ compileBlock value.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites class >> apply: compileBlock toVersionsFrom: aNumber [

	(aNumber >= SystemVersion current major) ifFalse: [ ^ self ].
	^ compileBlock value.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites class >> assertMethod: aCompiledMethod hasHash: aString [ 

	self assert: aCompiledMethod sha256HashString = aString
		description: [ 'Unexpected hash for: ', aCompiledMethod printString ].
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites class >> source: source withPatchPragma: aSymbol [
	"Answer the source code, ensuring that the supplied gtPharoPatch: pragma is present"
	| ast pragmaValue pragmaSource index |

	pragmaValue := aSymbol asSymbol.
	ast := RBParser parseMethod: source.
	ast pragmas 
		detect: [ :pragma | (pragma argumentAt: #gtPharoPatch:) value = pragmaValue ]
		ifFound: [ :pragma | ^ source ].
	pragmaSource := String streamContents: [ :stream |
		stream
			<< '<gtPharoPatch: #';
			<< aSymbol;
			<< '>';
			cr;
			tab ].
	index := ast body start.
	^ (source copyFrom: 1 to: index - 1),
		pragmaSource,
		(source copyFrom: index to: source size).
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFT2Face [
	| source compileBlock |

	source := 'newFaceFromExternalMemory: aFreeTypeExternalMemory index: anInteger
	| memSize holder returnCode retryCount |

	retryCount := 1.
	[ aFreeTypeExternalMemory validate.
	memSize := aFreeTypeExternalMemory bytes size.
	holder := PointerHolder new.

	FT2Library current checkLibrary.
	returnCode := FT2Library current
		              ffiNewFace: holder
		              fromMemory: aFreeTypeExternalMemory getHandle
		              size: memSize
		              index: anInteger.
	returnCode ~= 0 and: [ retryCount > 0 ] ] whileTrue:
		[ retryCount := retryCount - 1 ].
	returnCode ~= 0 ifTrue: [
		FT2Error
			errorCode: returnCode
			signal: ''Error reading new face from memory'' ].

	handle := holder value.
	self autoRelease'.
	compileBlock := [ 
		self class assertMethod: FT2Face >> #newFaceFromExternalMemory:index:
			hasHash: 'd09db5da25526bf306c3e7f110aa73154225b866b25577e1f6253d935539e2d6'.
		FT2Face compile: (self class 
				source: source withPatchPragma: #Pharo11)
			classified: 'gt-pharo-patch' ].
	self class apply: compileBlock toVersionsFrom: 11.
]

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
BaselineOfGToolkitPrerequisites >> applyPatchForFinalizationProcess [
	self 
		forPharo12: [
			FinalizationProcess
				addClassVarNamed: 'MournLoopProcess';
				addClassVarNamed: 'StopRequested';
				addClassVarNamed: 'StoppedSemaphore';
				initialize. 
		] 
		forPharo11AndPharo10: [
			Object subclass: #FinalizationProcess
	instanceVariableNames: ''
	classVariableNames: 'TheFinalizationProcess FinalizationSemaphore MournLoopProcess StopRequested StoppedSemaphore '
	package: 'GToolkit-UtilitySystemStubs'.
		] 
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
BaselineOfGToolkitPrerequisites >> applyPatchForPharo11StubsInPharo12 [
	self 
		forPharo12: [
			(Object << #ProtocolOrganizer
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #ClassOrganization
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #Categorizer
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #EpBehaviorCategoryChange
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #EpCategoryRename
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #EpCategoryChange
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AbstractProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AllProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
		] 
		forPharo11: [ ]
		forPharo10: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForWeakArray [
	self 
		forPharo12: [
			WeakArray
				addClassVarNamed: 'MournLoopProcess';
				addClassVarNamed: 'StopRequested';
				addClassVarNamed: 'StoppedSemaphore';
				addClassVarNamed: 'TheFinalizationProcess';
				addClassVarNamed: 'FinalizationSemaphore' ] 
		forPharo11AndPharo10: [ 
			WeakArray
				addClassVarNamed: 'MournLoopProcess';
				addClassVarNamed: 'StopRequested';
				addClassVarNamed: 'StoppedSemaphore';
				initialize.
			WeakArray class 
				compile: 'startUp: resuming
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	self restartFinalizationProcess'
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'shutDown: quitting
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	self stopFinalizationProcess'
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'restartFinalizationProcess
	"kill any old process, just in case"
	"DO NOT EDIT HERE"
	<gtPharoPatch: #Pharo11>

	self stopFinalizationProcess.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	StopRequested := false.
	FinalizationProcess := [self finalizationProcess]
		forkAt: Processor userInterruptPriority.
	FinalizationProcess name: ''WeakArray Finalization Process'''
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'stopFinalizationProcess
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	FinalizationProcess ifNotNil: 
		[FinalizationProcess terminate.
		FinalizationProcess := nil].

	(MournLoopProcess isNil or: [ MournLoopProcess isTerminated ])
		ifTrue: [ ^ self ].
	self assert: self stoppedSemaphore isSignaled not.
	StopRequested := true.
	StoppedSemaphore wait.'
				classified: 'gt-pharo-patch' ]
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
			package: 'GToolkit-PharoBasePatch-Deprecations';
			package: 'GToolkit-PharoBasePatch-Subscriptions' ;
			package: 'GToolkit-PharoBasePatch-Iceberg';
			package: 'GToolkit-PharoBasePatch-PharoIndex';
			package: 'GToolkit-PharoBasePatch-StrictSymbol'.
		self 
			forPharo12: [] 
			forPharo11: [
				spec
					package: 'GToolkit-PharoBasePatch-StrictSymbol-Overrides'] 
			forPharo10: [] ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> postLoadGToolkitPrerequisites: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self applyPatchForJob.
	self applyPatchForWeakArray.
	self applyPatchForFinalizationProcess.
	self applyPatchForFT2Face.
	self applyPatchForFT2Handle.
	self applyPatchForLeJsonV4Name.
	self applyPatchInlineMethodRefactoring.
	self applyPatchForPharo11StubsInPharo12.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> preLoadGToolkitPrerequisites: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true. 
]
