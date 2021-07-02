FT2Library current beNull.
FT2Library current setHandle: nil.
FFIMethodRegistry resetAll.

Smalltalk garbageCollect.
Smalltalk garbageCollect.
Smalltalk garbageCollect.

NonInteractiveTranscript stdout
    print: (FFIExternalResourceManager uniqueInstance instVarNamed: #registry) asArray;
    cr.

NonInteractiveTranscript stdout
    print: (ExternalAddress allSubInstances) ;
    cr.

"ExternalAddress allSubInstances in: [ :instances |
    ((instances at: 1) pointersTo) do: [ :p |
        NonInteractiveTranscript stdout
            print: p class;
            cr.
    ]
].
"


