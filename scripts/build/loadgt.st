
IceCredentialsProvider useCustomSsh: true.
IceCredentialsProvider sshCredentials
	publicKey: '/data/jenkins/.ssh/id_rsa.pub';
	privateKey: '/data/jenkins/.ssh/id_rsa'.

SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

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

[ 
	EpMonitor current disable.
	Metacello new	
		githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';	
		baseline: 'Iceberg';	
		load.
	Metacello new 
		baseline: 'GToolkitReleaser'; 
		repository: 'github://feenkcom/gtoolkit-releaser/src'; 
		load.
	GtRlRepositoriesCloner loadProject: 'GToolkit' fromRepository: 'github://feenkcom/gtoolkit/src'.
] ensure: [ EpMonitor current enable ].

#GtImageSetup asClass performSetupForRelease.

World closeAllWindowsDiscardingChanges.

Smalltalk snapshot: true andQuit: false.
