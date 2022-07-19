"
I provide utility methods for configuring a Glamorous Tookit image after loading the code for production of for local development. 

I provide the following two API methods: 
- {{gtMethod:GtImageSetup class>>#performLocalSetup}}: use when creating an image locally for development;
- {{gtMethod:GtImageSetup class>>#performSetupForRelease}}: used during the release process

The various configurations that I support are in class-side methods in the `actions` category. For example, setting a new logo or updating the {{gtClass:GtImage}} version.


"
Class {
	#name : #GtImageSetup,
	#superclass : #Object,
	#category : 'GToolkit-Setup'
}

{ #category : #actions }
GtImageSetup class >> cleanUpChangeSets [
	ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
	ChangeSet resetCurrentToNewUnnamedChangeSet.
]

{ #category : #actions }
GtImageSetup class >> cleanUpImageAfterLoad [
	self cleanUpMonticelloCaches.
	self cleanUpChangeSets.
	
	Smalltalk organization sortCategories.
	3 timesRepeat: [ 
		Smalltalk garbageCollect.
	 	Symbol compactSymbolTable ].
	
	Smalltalk garbageCollect.
]

{ #category : #actions }
GtImageSetup class >> cleanUpMonticelloCaches [
	MCFileBasedRepository flushAllCaches.
	MCMethodDefinition shutDown.
]

{ #category : #actions }
GtImageSetup class >> copyDataAndDocsFolders [
	| gtoolkitRepoFolders docFolders icebergRepositories |
	GtResourcesUtilityConstants localGtDirectory asFileReference ensureCreateDirectory.
	
	('localGtDirectory: ', GtResourcesUtilityConstants localGtDirectory printString) traceCr.
	
	gtoolkitRepoFolders := (IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent.
	
	icebergRepositories := IceRepository registry reject: [ :aRepository | 
		aRepository name = 'zinc' or: [
			aRepository location isNil or: [ 
				(aRepository location parent = gtoolkitRepoFolders) not ] ] ].
	
	docFolders := OrderedCollection new.
	icebergRepositories do: [ :aRepository | 
		docFolders 
			addAll: (aRepository location childrenMatching: 'doc');
			addAll: (aRepository location childrenMatching: 'data') ].
	docFolders 
		add: (gtoolkitRepoFolders asFileReference / 'gtoolkit' / 'lepiter');
		add: (gtoolkitRepoFolders asFileReference / 'lepiter' / 'test-data');
		add: (gtoolkitRepoFolders asFileReference / 'JSLink' / 'js');
		add: (gtoolkitRepoFolders asFileReference / 'PythonBridge' / 'PythonBridgeRuntime');
		add: (gtoolkitRepoFolders asFileReference / 'gtoolkit-external-process' / 'tests').

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

	"PythonBridge and JSLink need to be told where to find their runtime files.
	This should be a FileLocator so that it uses the local location, not the CI's"
	PBPharoPlatform runtimeSourceDirectory: GtResourcesUtilityConstants localGtDirectory / 'feenkcom/PythonBridge/PythonBridgeRuntime'.
	JSLinkPharoPlatform runtimeSourceDirectory: GtResourcesUtilityConstants localGtDirectory / 'feenkcom/JSLink/js'.

]

{ #category : #actions }
GtImageSetup class >> installLogo [
	GtWorldMenu setGtDesktopLogo.
]

{ #category : #api }
GtImageSetup class >> performLocalSetup [
	"Perform a setup for images that should be used locally for development."
	
	self recordSpaceTallyAtBeginning.
	self installLogo.
	self registerTools.
	self updateLocalVersion.
	self updateDocumentationDirectoryForLocalDevelopment.
	self cleanUpImageAfterLoad.
	self preparePharoCompletionCache.
	self registerGTNamespace.
	self recordSpaceTallyAtEnd
]

{ #category : #api }
GtImageSetup class >> performSetupForRelease [
	"Perform a setup for images that should be released. This should 
	be called on the CI server during the release process."
	
	self performSetupForRelease: 'patch'
]

{ #category : #api }
GtImageSetup class >> performSetupForRelease: aVersionComputationName [
	"Perform a setup for images that should be released. This should 
	be called on the CI server during the release process.
	
	aVersionComputationName must be one of the following:
	 - patch
	 - minor
	 - major"
	
	self recordSpaceTallyAtBeginning.
	self copyDataAndDocsFolders.
	self installLogo.
	self registerTools.
	self updateNextReleaseVersion: (GtRlSemanticVersionComputation named: aVersionComputationName).
	self cleanUpImageAfterLoad.
	self preparePharoCompletionCache.
	self registerGTNamespace.
	self recordSpaceTallyAtEnd.
]

{ #category : #api }
GtImageSetup class >> preparePharoCompletionCache [
	GtPharoIndex initializeCache
]

{ #category : #api }
GtImageSetup class >> recordSpaceTallyAtBeginning [
	GtSpaceTallyHistory recordDefaultSystemWideDataLabeled: 'Image Setup Start'
]

{ #category : #api }
GtImageSetup class >> recordSpaceTallyAtEnd [
	GtSpaceTallyHistory recordDefaultSystemWideDataLabeled: 'Image Setup End'
]

{ #category : #actions }
GtImageSetup class >> registerGTNamespace [
	RBClassModelFactory setRBNamespace: GtRBNamespace
]

{ #category : #actions }
GtImageSetup class >> registerTools [
	GtMoldableDebugger register.
	GtExpandableDebuggerElement register.
	GtEmergencyDebugger register.
	GtInspectorToolRegistryAdaptor register.
	GtPlaygroundToolRegistryAdaptor register.
]

{ #category : #api }
GtImageSetup class >> updateDocumentationDirectoryForLocalDevelopment [
	LepiterCoreDefaults defaultDocumentationDirectory: FileLocator imageDirectory 
		/ 'pharo-local'
		/ 'iceberg'
]

{ #category : #actions }
GtImageSetup class >> updateLocalVersion [
	| theVersion |
	
	theVersion := GtImage computeCurrentGToolkitVersion asDevSemanticVersion. 
	
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]

{ #category : #actions }
GtImageSetup class >> updateNextReleaseVersion: aVersionComputation [
	| theVersion |
	
	theVersion := GtImage computeNextGToolkitVersion: aVersionComputation.
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]
