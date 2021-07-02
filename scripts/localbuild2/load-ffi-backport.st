| packagesToDelete extensionMethods |

BlockClosure compile: 'onErrorDo: errorHandlerBlock
	"Evaluate the block represented by the receiver, and normally return it''s value.  If an error occurs, the errorHandlerBlock is evaluated, and it''s value is instead returned.  The errorHandlerBlock must accept zero or one parameter (the error object)."
	"Examples:
		[1 whatsUpDoc] onErrorDo: [:err | ''huh?''].
		[1 / 0] onErrorDo: [:err |
			ZeroDivide = err class
				ifTrue: [Float infinity]
				ifFalse: [self error: err]]
"
	^ self on: Error do: [:ex | errorHandlerBlock cull: ex]'.

  NonInteractiveTranscript stdout
    nextPutAll: 'Compiled BlockClosure>>#onErrorDo:';
    cr.

Pragma class compile: 'allNamed: aSymbol

^ Array streamContents: [ :aStream |
		SystemNavigation default allMethods
			do: [ :eachMethod |
				(eachMethod pragmaAt: aSymbol)
					ifNotNil: [ :aPragma | aStream nextPut: aPragma ] ] ]'.
  
  NonInteractiveTranscript stdout
    nextPutAll: 'Compiled Pragma class >> #allNamed:';
    cr.
  
Class compile: 'classVariableNamed: aString ifAbsent: absentBlock
	"Answer the Class Variable"

	^self classPool associationAt: aString asSymbol ifAbsent: absentBlock'.

NonInteractiveTranscript stdout
  nextPutAll: 'Compiled Class >> #classVariableNamed:ifAbsent:';
  cr.

  Context compile: 'compiledCode

	^method'.

  NonInteractiveTranscript stdout
    nextPutAll: 'Context >> #compiledCode';
    cr.


OSSDL2ExternalForm
compile: 'oldPrimCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB
    <primitive: ''primitiveCreateManualSurface'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

OSSDL2ExternalForm
compile: 'oldPrimDestroyManualSurface: surfaceID
    <primitive: ''primitiveDestroyManualSurface'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

OSSDL2ExternalForm
compile: 'oldPrimManualSurface: surfaceID setPointer: aPointer
    <primitive: ''primitiveSetManualSurfacePointer'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

OSSDL2ExternalForm
compile: 'primCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB
    <primitive: ''primitiveCreateManualSurface'' module: ''SurfacePlugin''>
    ^ self oldPrimCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB'
classified: 'primitives'.

OSSDL2ExternalForm
compile: 'primDestroyManualSurface: surfaceID
    <primitive: ''primitiveDestroyManualSurface'' module: ''SurfacePlugin''>
    ^ self oldPrimDestroyManualSurface: surfaceID'
classified: 'primitives'.

OSSDL2ExternalForm
compile: 'primManualSurface: surfaceID setPointer: aPointer
    <primitive: ''primitiveSetManualSurfacePointer'' module: ''SurfacePlugin''>
    ^ self oldPrimManualSurface: surfaceID setPointer: aPointer'
classified: 'primitives'.

LGitLibrary compile: 'preMethodBuildContext: sender builder: builder spec: functionSpec'.
LGitLibrary compile: 'postMethodBuildContext: sender builder: builder spec: functionSpec'.

EpMonitor disableDuring: [

Iceberg enableMetacelloIntegration: false.

#ExternalAddress asClass startUp: true.
#ExternalObject asClass startUp: true.
#FFICallbackThunk asClass startUp: true.
#FFIMethodRegistry asClass startUp: true.
#FT2Handle asClass startUp: true.

#FFICompilerPlugin asClass uninstall.

packagesToDelete := {
    #'Alien-Core'.
    #'UnifiedFFI-Tests'.
    #'UnifiedFFI-Legacy'.
    #'UnifiedFFI'.
    #'BaselineOfUnifiedFFI'.
    #'FFI-Kernel'.
    #'FFI-Pools'.
} collect: [ :each | each asPackage ].

extensionMethods := [
    | classesToRemove methods |

    classesToRemove := packagesToDelete flatCollect: [ :eachPackage | eachPackage definedClasses ].

    methods := classesToRemove flatCollect: [ :eachClass |
        eachClass extensionSelectors collect: [ :eachSelector |
            eachClass >> eachSelector ] ].
    methods := methods reject: [ :each | packagesToDelete includes: each package ].

    NonInteractiveTranscript stdout
         nextPutAll: 'Found ';
         nextPutAll: methods size asString;
         nextPutAll: ' extension methods.';
         cr.
    methods do: [ :eachMethod |
        NonInteractiveTranscript stdout
            nextPutAll: eachMethod methodClass name;
            nextPutAll: ' >> #';
            nextPutAll: eachMethod selector;
            nextPutAll: ' defined in ';
            nextPutAll: eachMethod package name;
            cr ].
    methods collect: [ :eachMethod |
        Dictionary new
            at: #class put: eachMethod methodClass name;
            at: #package put: eachMethod package name;
            at: #sourceCode put: eachMethod sourceCode;
            yourself ] ] value.

packagesToDelete do: [ :eachPackage | eachPackage removeFromSystem ].

Metacello new	
		githubUser: 'syrel' project: 'pharo9-ffi-backport' commitish: 'main' path: '';	
		baseline: 'FFI';	
        onConflictUseIncoming;
		load.

NonInteractiveTranscript stdout
  nextPutAll: 'Loaded FFI';
  cr.

	Metacello new	
		githubUser: 'pharo-project' project: 'pharo' commitish: 'Pharo9.0' path: 'src';	
		baseline: 'UnifiedFFI';	
    onConflictUseIncoming;
		load.

    NonInteractiveTranscript stdout
      nextPutAll: 'Loaded UnifiedFFI';
      cr.
].


EpMonitor disableDuring: [

Iceberg enableMetacelloIntegration: false.

Metacello new	
	githubUser: 'pharo-project' project: 'threadedFFI-Plugin' commitish: 'master' path: 'src';	
	baseline: 'ThreadedFFI';	
  onConflictUseIncoming;
	load.
 Iceberg enableMetacelloIntegration: true.
    NonInteractiveTranscript stdout
      nextPutAll: 'Loaded threadedFFI-Plugin';
      cr ].

(Smalltalk image allClasses
	select: [ :each | each isTrait not and: [ each superclass notNil ] ])
	select: [ :each | each superclass name beginsWith: 'AnObsolete' ]
	thenDo: [ :each |
		| realSuperClass |

		realSuperClass := (each superclass name copyReplaceAll:  'AnObsolete' with: '' ) asSymbol asClass.
		each superclass: realSuperClass ].

#FFICompilerPlugin asClass install.
#ExternalAddress asClass startUp: true.
#ExternalObject asClass startUp: true.
#FFIBackend asClass startUp: true.
#FFICallbackThunk asClass startUp: true.
#FFIMethodRegistry asClass startUp: true.
#FT2Handle asClass startUp: true.

extensionMethods do: [ :eachMethodDictionary |
    (eachMethodDictionary at: #class) asClass
        compile: (eachMethodDictionary at: #sourceCode)
        classified: '*', (eachMethodDictionary at: #package) ].

#ExternalAddress asClass compile: 'address
    "Answer the receiver''s integer address"

    ^ self asInteger'
    classified: 'converting'.
NonInteractiveTranscript stdout
  nextPutAll: 'Compiled ExternalAddress>>#address';
  cr.

#ExternalObject asClass compile: 'asExternalAddress
    ^ handle asExternalAddress'
    classified: 'converting'.
NonInteractiveTranscript stdout
  nextPutAll: 'Compiled ExternalObject>>#asExternalAddress';
  cr.

#FFICallback asClass compile: 'beNull
    backendCallback ifNotNil: [ :aBackendCallback | aBackendCallback beNull ]'
    classified: 'accessing'.
NonInteractiveTranscript stdout
  nextPutAll: 'Compiled FFICallback>>#beNull';
  cr.

"===================================
 Re-initialize FFIExternalStructure
==================================="
NonInteractiveTranscript stdout
  nextPutAll: 'Found ';
  nextPutAll: #FFIExternalStructure asClass allSubclasses size asString;
  nextPutAll: ' subclasses of FFIExternalStructure';
  cr.
#FFIExternalStructure asClass allSubclassesDo: [ :each |
    NonInteractiveTranscript stdout
      nextPutAll: 'Initializing ';
      nextPutAll: each name;
      cr.
each initialize ].

"===================================
 Re-initialize LGitExternalEnumerationUInt32
==================================="
NonInteractiveTranscript stdout
  nextPutAll: 'Found ';
  nextPutAll: #LGitExternalEnumerationUInt32 asClass withAllSubclasses size asString;
  nextPutAll: ' subclasses of FFIExternalStructure';
  cr.
#LGitExternalEnumerationUInt32 asClass withAllSubclassesDo: [ :each |
    NonInteractiveTranscript stdout
      nextPutAll: 'Initializing ';
      nextPutAll: each name;
      cr.
each initialize ].

FFIExternalReference allSubInstancesDo: [ :each | each setHandle: each createDefaultHandle ].
FT2Types initialize.
FT2Library current beNull.
FT2Library current setHandle: nil.
FFIMethodRegistry resetAll.
"===================================
 Fix references to Obsolete Classes
==================================="
SystemNavigation default allObjectsDo: [ :eachObject |
	(eachObject class name beginsWith: #AnObsolete)
		ifTrue: [
		    eachObject isClass ifTrue: [
		        | anActualClassName |

		        anActualClassName := (eachObject name copyReplaceAll:  'AnObsolete' with: '' ) asSymbol.
		        self environment
		            at: anActualClassName
		            ifPresent: [ :realClass | eachObject becomeForward: realClass ] ] ] ].

"===================================
            Clean-up
==================================="
packagesToDelete := nil.
extensionMethods := nil.

Smalltalk garbageCollect.

"===================================
            Save an quit
==================================="
NonInteractiveTranscript stdout
  nextPutAll: 'Saving and quitting';
  cr.

Smalltalk snapshot: true andQuit: true.