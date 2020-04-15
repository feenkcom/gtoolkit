
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
	Metacello new
		githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';
		baseline: 'Iceberg';
		load ] ensure: [ EpMonitor current enable ].

loadWarnings := OrderedCollection new.
[ 
	EpMonitor current disable.
	Metacello new
		baseline: 'GToolkit';
		repository: 'github://feenkcom/gtoolkit/src';
		onWarning: [ :anException |
			"Log the error now."
			MetacelloNotification signal: anException description.
			"Create a list of all warnings."
			loadWarnings add: anException description.
			
			anException resume ];
		load ] ensure: [ EpMonitor current enable ].

"In case there are warnings during the loading fail here.
Otherwise most likely the failure will happen only when 
running tests or when running releaser."
loadWarnings ifNotEmpty: [  
	Error signal: (String streamContents: [ :aStream |
		aStream nextPutAll: 'Warnings detected during loading: '.
		aStream nextPutAll: OSPlatform current lineEnding.
		loadWarnings 
			asStringOn: aStream 
			delimiter: OSPlatform current lineEnding ]) ].

GtRlReleaserExportWorkflow switchAllRepositoriesBackToMasterBranch.

GtResourcesUtilityConstants localGtDirectory asFileReference ensureCreateDirectory.
Transcript crShow: ('localGtDirectory: ', GtResourcesUtilityConstants localGtDirectory printString).
docFolders := (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'doc') asOrderedCollection.

docFolders addAll:  (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'data').

docFolders do: [ :each |
	|icebergIndex size topSegments localPath|
	icebergIndex := each absolutePath segments indexOf: 'iceberg'.
	size := each absolutePath segments size.
	topSegments := each absolutePath segments asOrderedCollection copyFrom: (icebergIndex + 1) to: size.

	localPath := String streamContents: [ :stream | topSegments asStringOn: stream delimiter:'/'].
	Transcript crShow: ('copying ', each printString, ' to ', localPath).
	[each copyAllTo: (GtResourcesUtilityConstants localGtDirectory asFileReference / localPath) ] on: FileExists do: [ :e | Transcript crShow: e printString ]].
	
World closeAllWindowsDiscardingChanges.
#GtWorldMenu asClass setGtDesktopLogo.
#GtInspectorToolRegistryAdaptor asClass register. 
#GtPlaygroundToolRegistryAdaptor asClass register.

theVersion := GtRlReleaserExportWorkflow buildGToolkitRelease rootProjectRelease version.
GtImage version: theVersion.
GtImage timestamp: DateAndTime now.

Smalltalk snapshot: true andQuit: false.
