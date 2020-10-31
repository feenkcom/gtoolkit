Context compile: 'copyTo: aContext
	"Copy self and my sender chain down to, but not including, aContext.  
	End of copied chain will have nil sender."

	| copy |
	self == aContext ifTrue: [^ nil].

	"Workaround for the regular VM crash that occurs when copying self below.
	Accessing the pc seems to be enough to prevent the crash."
	self pc.

	copy := self copy.
	self sender ifNotNil: [
		copy privSender: (self sender copyTo: aContext)].
	^ copy'.

SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

EpMonitor disableDuring: [
	Metacello new	
		githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';	
		baseline: 'Iceberg';	
		load.
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
