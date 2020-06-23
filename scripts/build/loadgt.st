
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

IceGitWorkingCopyUpdateVisitor compile: 'remoteFileReferenceInPath: anUndefinedObject 
	
	"I do not remove nothing from the file in the image"'.

[ 
	EpMonitor current disable.
	Metacello new baseline: 'GToolkitReleaser'; repository: 'github://feenkcom/gtoolkit-releaser/src'; load.
	GtRlRepositoriesCloner loadProject: 'GToolkit' fromRepository: 'github://feenkcom/gtoolkit/src'.
] ensure: [ EpMonitor current enable ].

#GtImageSetup asClass performSetupForRelease.

World closeAllWindowsDiscardingChanges.

Smalltalk snapshot: true andQuit: false.
