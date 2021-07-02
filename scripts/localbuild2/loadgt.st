
EpMonitor disableDuring: [

    Metacello new
		baseline: 'GToolkitReleaser';
		githubUser: 'feenkcom' project: 'gtoolkit-releaser' commitish: 'master' path: '';
		load.

    GtRlProjectsLoader new
		loadBaseline: 'GToolkit' 
		fromRepository: 'github://feenkcom/gtoolkit/src'.

	"Metacello new
		baseline: 'GToolkit'; 
		repository: 'github://feenkcom/gtoolkit/src';
		silently;
		onConflictUseIncoming;
		load."
].


PharoLightTheme beCurrent.
#GtImageSetup asClass performLocalSetup.
World closeAllWindowsDiscardingChanges.
Smalltalk snapshot: true andQuit: false.
