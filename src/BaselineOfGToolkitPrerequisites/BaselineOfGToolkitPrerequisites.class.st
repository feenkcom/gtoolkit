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

	(SystemVersion current major >= aNumber) ifFalse: [ ^ self ].
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
BaselineOfGToolkitPrerequisites >> applyPatchAuthor [
	self 
		fastForPharo13: [
			#Author asClass compile: 'useAuthor: aString during: aBlock
	<gtPharoPatch: #Pharo13>
			
	^ aBlock value' classified: 'gt-patch'.] 
		forPharo12: [ ] 
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForAsClass [
	self 
		fastForPharo13AndPharo12: [
			String compile: 'asClass
	<gtPharoPatch: #Pharo12>
	"returns a global class with my name"
	^ self asClassInEnvironment: Smalltalk globals'
classified: 'gt-pharo-patch'.
		] 
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFT2Face [
	| source |

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
	
	self class assertMethod: FT2Face >> #newFaceFromExternalMemory:index:
		hasHash: 'd09db5da25526bf306c3e7f110aa73154225b866b25577e1f6253d935539e2d6'.
	FT2Face compile: (self class 
			source: source withPatchPragma: #Pharo11)
		classified: 'gt-pharo-patch' 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFT2Handle [
	self 
		fastForPharo13AndPharo12: [] 
		forPharo11: [
			FT2Handle class 
				compile: 'startUp: isImageStarting
	<gtPharoPatch: #Pharo11>'
			classified: 'startup']
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFinalizationProcess [
	self 
		fastForPharo13AndPharo12: [ self applyPatchForFinalizationProcessPharo12Plus ] 
		forPharo11: [ "self applyPatchForFinalizationProcessPharo11" ] 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFinalizationProcessPharo11 [

	Object subclass: #FinalizationProcess
		instanceVariableNames: ''
		classVariableNames: 'TheFinalizationProcess FinalizationSemaphore MournLoopProcess StopRequested StoppedSemaphore'
		package: 'GToolkit-UtilitySystemStubs'.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForFinalizationProcessPharo12Plus [

	(#FinalizationProcess asClassInEnvironment: Smalltalk globals)
		addClassVarNamed: 'MournLoopProcess';
		addClassVarNamed: 'StopRequested';
		addClassVarNamed: 'StoppedSemaphore';
		initialize.

	FinalizationProcess class compile:
'finalizationProcess
	"The finalization process arranges to send mourn to each element of the VM''s finalization queue,
	 which is accessed via primitiveFetchMourner.  The VM signals FinalizationSemaphore whenever
	 the queue is non-empty.  This process loops, waiting on the semaphore, fetches the first element
	 of the queue and then spawns a process at a higher priority to actually send the mourn messages.
	 If an error occurs in the higher priority mourn loop process then this process will simply spawn
	 another process, hence ensuring that errors in finalization methods don''t break finalization.

	 In addition this process also runs the old finalization scheme, supporting clients of the older,
	 WeakRegistry based scheme.  Hopefully this will go away when all clients have moved over."
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	| throttle firstMourner |

	throttle := Semaphore new.
	[ FinalizationSemaphore wait; initSignals.
	[ (firstMourner := self primitiveFetchMourner) notNil] whileTrue:
		[ MournLoopProcess := [
			[ [ self mournLoopWith: firstMourner]
				on: Error
				fork: [ :ex | ex pass ] ]
					ensure: [ throttle signal ].
			] forkAt: Processor activePriority + 1.
	 	throttle wait ] ] repeat'
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'gtSummaryFor: aView
	<gtView>
	<gtClassView>
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	^ aView columnedList
		title: ''Summary'';
		priority: 10;
		items: [ {
			''FinalizationProcess'' -> TheFinalizationProcess.
			''FinalizationSemaphore'' -> FinalizationSemaphore size.
			''MournLoopProcess'' -> MournLoopProcess. } ];
		column: ''Item'' text: #key;
		column: ''Value'' text: #value;
		actionUpdateButton.'
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'mournLoopWith: firstMourner
	"Send mourn to all the objects available in the mourn queue, starting
	 with firstMourner which the sender has already extracted for us.  If
	 an error occurs here, it will break this loop but the sender will spawn
	 another mournLoopWith: so that finalization is not broken by errors in
	 individual cases."
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	| mourner |
	mourner := firstMourner.
	[ [] ensure: [ mourner mourn ].
	 mourner := self primitiveFetchMourner.
	 mourner notNil ] whileTrue.
	MournLoopProcess := nil.'
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'restartFinalizationProcess
	"kill any old process, just in case"
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	self stopFinalizationProcess.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	TheFinalizationProcess := [self finalizationProcess]
		forkAt: Processor userInterruptPriority.
	TheFinalizationProcess name: ''WeakArray Finalization Process'''
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'shutDown: quitting
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	self stopFinalizationProcess'
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'startUp: resuming
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	self restartFinalizationProcess'
		classified: 'gt-pharo-patch'.

	FinalizationProcess class compile:
'stopFinalizationProcess
	<gtPharoPatch: #Pharo12>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForFinalizationProcessPharo12Plus"
	TheFinalizationProcess ifNotNil: 
		[TheFinalizationProcess terminate.
		TheFinalizationProcess := nil].

	MournLoopProcess ifNil: [ ^ self ].
	(MournLoopProcess isTerminated or: [ MournLoopProcess isTerminating ]) ifFalse:
		 [ MournLoopProcess terminate ].
	MournLoopProcess := nil.'
		classified: 'gt-pharo-patch'.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForJob [
	self 
		fastForPharo13AndPharo12: [] 
		forPharo11: [ Job addSlot: #announcer ] 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForLeJsonV4Name [

	#(#FinalizationRegistryEntry #WeakKeyAssociation) do: [ :aClassName | 
		aClassName asClass classSide 
			compile: 'leJsonV4Name

	^ nil' classified: 'serialisation' ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForPharo11StubsInPharo12 [
	self 
		fastForPharo13: []
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
			(Object << #EpCategoryChange
				slots: { #classCategoryName . #affectedPackageName};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryAddition
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRegistration
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRemoval
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRename
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AbstractProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AllProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #ChangeSet
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #EpIconVisitor
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
		] 
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForPharo11StubsInPharo13 [
	self 
		fastForPharo13: [
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
			(Object << #EpCategoryChange
				slots: { #classCategoryName . #affectedPackageName};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryAddition
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRegistration
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRemoval
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(#EpCategoryChange asClass << #EpCategoryRename
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AbstractProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #AllProtocol
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #ChangeSet
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
			(Object << #EpIconVisitor
				slots: {};
				package: 'GToolkit-Pharo11Stubs') install.
		] 
		forPharo12: []
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForPharo12StubsInPharo11 [
	self 
		fastForPharo13AndPharo12: [ ] 
		forPharo11: [
			(Object << #EpBehaviorRepackagedChange
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
		

			(Object << #EpPackageChange
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageChange asClass << #EpPackageAddition
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageChange asClass << #EpPackageRemoval
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageChange asClass << #EpPackageRename
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
				
			(Object << #EpPackageTagChange
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageTagChange asClass << #EpPackageTagAddition
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageTagChange asClass << #EpPackageTagRemoval
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
			(#EpPackageTagChange asClass << #EpPackageTagRename
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
				.
			(Object << #EpIconNameVisitor
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
				
			(Object << #RBAbstractTransformation
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForPharo12StubsInPharo13 [
	self 
		fastForPharo13: [
			(Object << #Author
				slots: {};
				package: 'GToolkit-Pharo12Stubs') install.
		] 
		forPharo12: []
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForPharo12SystemDictionaryAtPut [

	self 
		fastForPharo13: []
		forPharo12: [ SystemDictionary compile:
'at: aKey put: anObject
	"Override from Dictionary to check Undeclared and fix up
	references to undeclared variables."
	| index assoc registeredMethods |
	aKey isSymbol ifFalse: [ self error: ''Only symbols are accepted as keys in SystemDictionary'' ].

	registeredMethods := #().

	((self includesKey: aKey) not and: [ Undeclared includesKey: aKey ]) ifTrue: [
 			| undeclared |
 			undeclared := Undeclared associationAt: aKey.
 			"Undeclared variables record using methods in a property, remove. Boostrap might have used Associations"
 			(undeclared class == UndeclaredVariable) ifTrue: [
				registeredMethods := undeclared removeProperty: #registeredMethods ifAbsent: [ #() ]]. 
 			"and change class to be Global" 
 			self add: (undeclared primitiveChangeClassTo: GlobalVariable new).
 			Undeclared removeKey: aKey].
 	"code of super at:put:, not using Associations but GlobalVariable"
 	index := self findElementOrNil: aKey.
 	assoc := array at: index.
 	"GT Pharo patch:  Always flush the cache.
 	Pharo 12 only flushes if the association isNil, but if it is in Undeclared the cachedClassNames need to be updated."
 	assoc
 		ifNil: [self atNewIndex: index put: (GlobalVariable key: aKey value: anObject) ]
 		ifNotNil: [assoc value: anObject].
 	self flushClassNameCache.
		
	registeredMethods do: [ :aMethod | aMethod isInstalled ifTrue: [aMethod recompile] ].		

 	^ anObject'
			classified: 'gt-pharo-patch' ] 
		forPharo11: [ ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForWeakArray [
	self 
		fastForPharo13AndPharo12: [] 
		forPharo11: [ 
			WeakArray
				addClassVarNamed: 'MournLoopProcess';
				addClassVarNamed: 'StopRequested';
				addClassVarNamed: 'StoppedSemaphore';
				initialize.
			WeakArray class compile:
'finalizationProcess
	"The finalization process arranges to send mourn to each element of the VM''s finalization queue,
	 which is accessed via primitiveFetchMourner.  The VM signals FinalizationSemaphore whenever
	 the queue is non-empty.  This process loops, waiting on the semaphore, fetches the first element
	 of the queue and then spawns a process at a higher priority to actually send the mourn messages.
	 If an error occurs in the higher priority mourn loop process then this process will simply spawn
	 another process, hence ensuring that errors in finalization methods don''t break finalization.

	 In addition this process also runs the old finalization scheme, supporting clients of the older,
	 WeakRegistry based scheme.  Hopefully this will go away when all clients have moved over."
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	| throttle firstMourner |
	throttle := Semaphore new.
	[true] whileTrue: [FinalizationSemaphore wait; initSignals.

	 [firstMourner := self primitiveFetchMourner.
	  firstMourner notNil] whileTrue:
		[MournLoopProcess := [
			[ [ self mournLoopWith: firstMourner]
				on: Error
				fork: [ :ex | ex pass ] ]
					ensure: [ throttle signal ].
		] newProcess.
		MournLoopProcess priority: Processor activePriority + 1.
		AsyncProcessProperties
			process: MournLoopProcess
			property: #parentProcess
			put: Processor activeProcess.
		MournLoopProcess resume.
		 throttle wait]]'
		 		classified: 'gt-pharo-patch'.
			WeakArray class compile:
'gtSummaryFor: aView
	<gtView>
	<gtClassView>
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	^ aView columnedList
		title: ''Summary'';
		priority: 10;
		items: [ {
			''FinalizationProcess'' -> FinalizationProcess.
			''FinalizationSemaphore'' -> FinalizationSemaphore size.
			''MournLoopProcess'' -> MournLoopProcess.
			''StopRequested'' -> StopRequested.
			''StoppedSemaphore'' -> StoppedSemaphore size. } ];
		column: ''Item'' text: #key;
		column: ''Value'' text: #value;
		actionUpdateButton.'
				classified: 'gt-pharo-patch'.
			WeakArray class compile:
'mournLoopWith: firstMourner
	"Send mourn to all the objects available in the mourn queue, starting
	 with firstMourner which the sender has already extracted for us.  If
	 an error occurs here, it will break this loop but the sender will spawn
	 another mournLoopWith: so that finalization is not broken by errors in
	 individual cases."
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	| mourner |
	mourner := firstMourner.
	[ self stopRequested ifTrue:
		[ self stoppedSemaphore signal.
		MournLoopProcess := nil.
		^ self ].
	mourner mourn.
	 (mourner := self primitiveFetchMourner) notNil] whileTrue.
	MournLoopProcess := nil.'
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'restartFinalizationProcess
	"kill any old process, just in case"
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	self stopFinalizationProcess.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	StopRequested := false.
	FinalizationProcess := [self finalizationProcess]
		forkAt: Processor userInterruptPriority.
	FinalizationProcess name: ''WeakArray Finalization Process'''
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'shutDown: quitting
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"

	self stopFinalizationProcess'
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'startUp: resuming
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"

	self restartFinalizationProcess'
				classified: 'gt-pharo-patch'.
			WeakArray class 
				compile: 'stopFinalizationProcess
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"

	FinalizationProcess ifNotNil: 
		[FinalizationProcess terminate.
		FinalizationProcess := nil].

	(MournLoopProcess isNil or: [ MournLoopProcess isTerminated ])
		ifTrue: [ ^ self ].
	self assert: self stoppedSemaphore isSignaled not.
	StopRequested := true.
	StoppedSemaphore wait.'
				classified: 'gt-pharo-patch'.
			WeakArray class compile:
'stopRequested
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	^ StopRequested ifNil: [ false ]'
				classified: 'gt-pharo-patch'.
			WeakArray class compile:
'stoppedSemaphore
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE, see BaselineOfGToolkitPrerequisites>>#applyPatchForWeakArray"
	^ StoppedSemaphore ifNil: [ StoppedSemaphore := Semaphore new ]'
				classified: 'gt-pharo-patch'.
		 ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchForWorkingSession [
	self 
		fastForPharo13AndPharo12: [ WorkingSession addSlot: #id  ] 
		forPharo11: [ ] 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> applyPatchInlineMethodRefactoring [
	
	
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
	^ inlineClass' classified: 'transforming'. 
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec preLoadDoIt: #preLoadGToolkitPrerequisites:.
		spec postLoadDoIt: #postLoadGToolkitPrerequisites:.
		spec
			package: 'GToolkit-PharoBasePatch-Deprecations';
			package: 'GToolkit-PharoBasePatch-SymbolTableSemaphore-Base';
			package: 'GToolkit-PharoBasePatch-SymbolTableSemaphore-Patch'
				with: [ spec requires: #('GToolkit-PharoBasePatch-SymbolTableSemaphore-Base') ] ;
			package: 'GToolkit-PharoBasePatch-Extensions';
			package: 'GToolkit-PharoBasePatch-Subscriptions' ;
			package: 'GToolkit-PharoBasePatch-Iceberg';
			package: 'GToolkit-PharoBasePatch-PharoIndex';
			package: 'GToolkit-PharoBasePatch-StrictSymbol';
			package: 'GToolkit-PharoBasePatch-ForPharo12'.
		self 
			fastForPharo13: []
			forPharo12: [] 
			forPharo11: [
				spec
					package: 'GToolkit-PharoBasePatch-StrictSymbol-Overrides']  ]
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> postLoadGToolkitPrerequisites: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	self applyPatchForAsClass.
	self applyPatchForJob.
	self applyPatchForWorkingSession.
	self applyPatchForWeakArray.
	self applyPatchForFinalizationProcess.
	self applyPatchForFT2Face.
	self applyPatchForFT2Handle.
	self applyPatchForLeJsonV4Name.
	self applyPatchInlineMethodRefactoring.
	self applyPatchForPharo12SystemDictionaryAtPut.
	self applyPatchForPharo11StubsInPharo12.
	self applyPatchForPharo11StubsInPharo13.
	self applyPatchForPharo12StubsInPharo13.
	self applyPatchForPharo12StubsInPharo11.
	self applyPatchAuthor.
]

{ #category : #accessing }
BaselineOfGToolkitPrerequisites >> preLoadGToolkitPrerequisites: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true. 
]
