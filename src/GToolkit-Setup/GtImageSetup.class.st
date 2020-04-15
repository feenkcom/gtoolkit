Class {
	#name : #GtImageSetup,
	#superclass : #Object,
	#category : #'GToolkit-Setup'
}

{ #category : #actions }
GtImageSetup class >> copyDataAndDocsFolders [
	| gtoolkitRepoFolders docFolders |
	GtResourcesUtilityConstants localGtDirectory asFileReference ensureCreateDirectory.
	
	('localGtDirectory: ', GtResourcesUtilityConstants localGtDirectory printString) traceCr.
	
	gtoolkitRepoFolders := (IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent.
	docFolders := OrderedCollection new
		addAll: (gtoolkitRepoFolders allChildrenMatching: 'doc');
		addAll: (gtoolkitRepoFolders allChildrenMatching: 'data');
		yourself.

	docFolders do: [ :each |
		|icebergIndex size topSegments localPath|
		icebergIndex := each absolutePath segments indexOf: 'iceberg'.
		size := each absolutePath segments size.
		topSegments := each absolutePath segments asOrderedCollection copyFrom: (icebergIndex + 1) to: size.
		localPath := String streamContents: [ :stream | topSegments asStringOn: stream delimiter:'/'].
		
		('copying ', each printString, ' to ', localPath) traceCr.
		[each copyAllTo: (GtResourcesUtilityConstants localGtDirectory asFileReference / localPath) ] 
			on: FileExists 
			do: [ :e | e printString traceCr ]].
]

{ #category : #actions }
GtImageSetup class >> installLogo [
	GtWorldMenu setGtDesktopLogo.
]

{ #category : #actions }
GtImageSetup class >> performSetup [
	self copyDataAndDocsFolders.
	self installLogo.
	self registerTools.
	self updateImageVersion.
]

{ #category : #api }
GtImageSetup class >> registerTools [
	GtMoldableDebuggerElement register.
	GtInspectorToolRegistryAdaptor register.
	GtPlaygroundToolRegistryAdaptor register.
]

{ #category : #actions }
GtImageSetup class >> updateImageVersion [
	| theVersion |
	theVersion := GtRlReleaserExportWorkflow buildGToolkitRelease rootProjectRelease version.
	
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]
