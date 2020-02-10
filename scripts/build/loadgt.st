
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
	
EpMonitor current disable.
Metacello new
  baseline: 'GToolkit';
  repository: 'github://feenkcom/gtoolkit/src';
  load.
EpMonitor current enable.
GtRlReleaserExportWorkflow switchAllRepositoriesBackToMasterBranch.

GtDocumentConstants localGtDirectory asFileReference ensureCreateDirectory.
Transcript crShow: ('localGtDirectory: ', GtDocumentConstants localGtDirectory printString).
docFolders := (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'doc') asOrderedCollection.

docFolders addAll:  (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'data').

docFolders do: [ :each |
	|icebergIndex size topSegments localPath|
	icebergIndex := each absolutePath segments indexOf: 'iceberg'.
	size := each absolutePath segments size.
	topSegments := each absolutePath segments asOrderedCollection copyFrom: (icebergIndex + 1) to: size.

	localPath := String streamContents: [ :stream | topSegments asStringOn: stream delimiter:'/'].
	Transcript crShow: ('copying ', each printString, ' to ', localPath).
	[each copyAllTo: (GtDocumentConstants localGtDirectory asFileReference / localPath) ] on: FileExists do: [ :e | Transcript crShow: e printString ]].
	
World closeAllWindowsDiscardingChanges.
#GtWorldMenu asClass setGtDesktopLogo.

theVersion := GtRlReleaserExportWorkflow buildGToolkitRelease rootProjectRelease version.
GTImageVersion version: theVersion.
GTImageVersion timestamp: DateAndTime now.

Smalltalk snapshot: true andQuit: false.
