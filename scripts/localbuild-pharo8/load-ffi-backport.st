LGitLibrary compile: 'preMethodBuildContext: sender builder: builder spec: functionSpec'.
LGitLibrary compile: 'postMethodBuildContext: sender builder: builder spec: functionSpec'.

EpMonitor current disable.
Iceberg enableMetacelloIntegration: false.

#ExternalAddress asClass startUp: true.
#ExternalObject asClass startUp: true.
#FFICallbackThunk asClass startUp: true.
#FFIMethodRegistry asClass startUp: true.
#FT2Handle asClass startUp: true.

#FFICompilerPlugin asClass uninstall.

PharoPatcher updatePackages:
{
    #'Alien-Core'.
    #'UnifiedFFI-Tests'.
    #'UnifiedFFI-Legacy'.
    #'UnifiedFFI'.
    #'BaselineOfUnifiedFFI'.
    #'FFI-Kernel'.
    #'FFI-Pools'.
} during: [

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

Metacello new
    githubUser: 'pharo-project' project: 'pharo' commitish: 'Pharo9.0' path: 'src';
    baseline: 'ThreadedFFI';
    onConflictUseIncoming;
    load.

NonInteractiveTranscript stdout
    nextPutAll: 'Loaded threadedFFI-Plugin';
    cr.
].

#FFICompilerPlugin asClass install.
#ExternalAddress asClass startUp: true.
#ExternalObject asClass startUp: true.
#FFIBackend asClass startUp: true.
#FFICallbackThunk asClass startUp: true.
#FFIMethodRegistry asClass startUp: true.
#FT2Handle asClass startUp: true.

PharoPatcher patch: #ExternalAddress asClass source:
'address
    "Answer the receiver''s integer address"

    ^ self asInteger'
classified: 'converting'.

PharoPatcher patch: #ExternalObject asClass source:
'asExternalAddress
    ^ handle asExternalAddress'
classified: 'converting'.

PharoPatcher patch: #FFICallback asClass source:
'beNull
    backendCallback ifNotNil: [ :aBackendCallback | aBackendCallback beNull ]'
classified: 'accessing'.

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
Smalltalk garbageCollect.

EpMonitor current enable.
Iceberg enableMetacelloIntegration: true.
"===================================
            Save an quit
==================================="
NonInteractiveTranscript stdout
  nextPutAll: 'Saving and quitting';
  cr.

Smalltalk snapshot: true andQuit: true.