SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

EpMonitor disableDuring: [
    Metacello new 
	baseline: 'GToolkitReleaser'; 
	githubUser: 'feenkcom' project: 'gtoolkit-releaser' commitish: 'master' path: ''; 
	load.
    GtRlRepositoriesCloner loadProject: 'GToolkit' fromRepository: 'github://feenkcom/gtoolkit/src'.
].


PharoLightTheme beCurrent.
#GtImageSetup asClass performLocalSetup.
World closeAllWindowsDiscardingChanges.
Smalltalk snapshot: true andQuit: false.
