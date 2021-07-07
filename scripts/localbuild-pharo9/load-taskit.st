EpMonitor current disable.
Iceberg enableMetacelloIntegration: false.

PharoPatcher updatePackages:
{
    #'TaskIt'.
    #'TaskIt-Tests'.
    #'BaselineOfTaskIt'.
}
during: [
Metacello new
    githubUser: 'syrel' project: 'pharo-shims' commitish: 'main' path: 'src';
    baseline: 'PharoShims';
    onConflictUseIncoming;
    load.
NonInteractiveTranscript stdout
    nextPutAll: 'Loaded PharoShims';
    cr.
Metacello new
    githubUser: 'pharo-contributions' project: 'CollectionExtensions' commitish: 'v1.x.x' path: 'src';
    baseline: 'CollectionExtensions';
    load.
NonInteractiveTranscript stdout
    nextPutAll: 'CollectionExtensions';
    cr.
Metacello new
    githubUser: 'feenkcom' project: 'taskit' commitish: 'feenk102' path: '';
    baseline: 'TaskIt';
    onConflictUseIncoming;
    load.

NonInteractiveTranscript stdout
    nextPutAll: 'Loaded TaskIt';
    cr.
].

#Iceberg asClass enableMetacelloIntegration: true.
EpMonitor current enable.

Smalltalk snapshot: true andQuit: false.