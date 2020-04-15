SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

[ 
	EpMonitor current disable.
	Metacello new
       		githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';
        	baseline: 'Iceberg';
        	load.

	Metacello new
 		baseline: 'GToolkit';
 		repository: 'github://feenkcom/gtoolkit/src';
		load ] ensure: [ EpMonitor current enable].
PharoLightTheme beCurrent.

GtImageSetup performLocalSetup.

World closeAllWindowsDiscardingChanges.

Smalltalk snapshot: true andQuit: false.
