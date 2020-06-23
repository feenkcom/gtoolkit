SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

Metacello new
    githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'v1.8.3' path: '';
    baseline: 'Iceberg';
    load.
Metacello new baseline: 'GToolkitReleaser'; repository: 'github://feenkcom/gtoolkit-releaser/src'; load.
GtRlRepositoriesCloner loadProject: 'GToolkit' fromRepository: 'github://feenkcom/gtoolkit/src'.



PharoLightTheme beCurrent.
#GtImageSetup asClass performLocalSetup.
World closeAllWindowsDiscardingChanges.
Smalltalk snapshot: true andQuit: false.
