"
I provide utility methods for configuring a Glamorous Tookit image after loading the code for production of for local development. 

I provide the following two API methods: 
- ${method:GtImageSetup class>>#performLocalSetup}$: use when creating an image locally for development;
- ${method:GtImageSetup class>>#performSetupForRelease}$: used during the release process

The various configurations that I support are in class-side methods in the ==actions== category. For example, setting a new logo or updating the ${class:GtImage}$ version.


"
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

{ #category : #api }
GtImageSetup class >> performLocalSetup [
	"Perform a setup for images that should be used locally for development."
	
	self installLogo.
	self registerTools.
	self updateLocalVersion.
]

{ #category : #api }
GtImageSetup class >> performSetupForRelease [
	"Perform a setup for images that should be released. This should 
	be called on the CI server during the release process"
	
	self copyDataAndDocsFolders.
	self installLogo.
	self registerTools.
	self updateNextReleaseVersion.
]

{ #category : #actions }
GtImageSetup class >> registerTools [
	GtMoldableDebuggerElement register.
	GtInspectorToolRegistryAdaptor register.
	GtPlaygroundToolRegistryAdaptor register.
	Smalltalk globals at: #Transcript put: GtTranscript default
]

{ #category : #actions }
GtImageSetup class >> updateLocalVersion [
	| gtoolkitRepository releaseTags theVersion |
	gtoolkitRepository := IceRepository registry 
		detect: [ :anIceRepository | anIceRepository name = 'gtoolkit' ]
		ifNone: [ ^ self ].
	
	releaseTags := ((gtoolkitRepository tags 
		select: #gtIsSemanticVersion
		thenCollect: [ :anIceTag | 
			anIceTag gtAsSemanticVersionNumber]) sorted: [ :a :b |
				a <= b ]).
	releaseTags ifEmpty: [ ^ self ].
	theVersion := releaseTags last asDevSemanticVersion. 
	
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]

{ #category : #actions }
GtImageSetup class >> updateNextReleaseVersion [
	| theVersion |
	theVersion := GtRlReleaserExportWorkflow buildGToolkitRelease rootProjectRelease version.
	
	GtImage version: theVersion.
	GtImage timestamp: DateAndTime now.
]
