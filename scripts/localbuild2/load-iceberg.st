| packagesToDelete extensionMethods |
EpMonitor current disable.
Iceberg enableMetacelloIntegration: false.

LGitLibrary shutDown: true.

PharoPatcher updatePackages:
{
    #'LibGit-Core'.
    #'LibGit-FileSystem'.
    #'BaselineOfLibGit'.
    #'BaselineOfIceberg'.
}, (RPackage organizer packages select: [ :each | each name beginsWith: 'Iceberg' ] thenCollect: [ :each | each name ])
during: [

Metacello new
    githubUser: 'pharo-vcs' project: 'libgit2-pharo-bindings' commitish: 'v2.1.6' path: '';
    baseline: 'LibGit';
    load.

NonInteractiveTranscript stdout
    nextPutAll: 'Loaded libgit2-pharo-bindings';
    cr.

Metacello new
    githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.8' path: '';
    baseline: 'Iceberg';
    load.

NonInteractiveTranscript stdout
    nextPutAll: 'Loaded Iceberg';
    cr.
].

"===================================
        Patch Library names
==================================="
PharoPatcher patch: #LGitLibrary asClass source:
'macLibraryName

 	^ FFIMacLibraryFinder findAnyLibrary: #(''libgit2.dylib'' ''libgit2.1.0.1.dylib'' ''libgit2.1.0.0.dylib'' ''libgit2.0.25.1.dylib'')'
classified: 'accessing - platform'.

#Iceberg asClass enableMetacelloIntegration: true.
EpMonitor current enable.

Smalltalk snapshot: true andQuit: false.