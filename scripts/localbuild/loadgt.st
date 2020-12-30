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
		
RPackageOrganizer compile: 'packageMatchingExtensionName: anExtensionName
	"return nil if no package is not found"
	| tmpPackageName |
	
	"we first look if their is a package matching exactly the name specified"
	(self packageExactlyMatchingExtensionName: anExtensionName)
		ifNotNil: [ :package | ^ package ].
	
	"if no package was found, we try to find one matching the begining of the name specified"
	tmpPackageName := ''''.
	packages keysDo: [:aSymbol |
		(anExtensionName beginsWithEmpty: (aSymbol asString, ''-'') caseSensitive: false)
			ifTrue: [
				"we keep the longest package name found"
				(aSymbol size > tmpPackageName size) 
					ifTrue: [ tmpPackageName := aSymbol ]]].
	
	^ tmpPackageName = ''''
		ifTrue: [ nil ] 
		ifFalse: [ self packageNamed: tmpPackageName ]'.
		
RPackageOrganizer compile: 'hasPackageMatchingExtensionName: anExtensionName
	(self hasPackageExactlyMatchingExtensionName: anExtensionName)
		ifTrue: [ ^true ].
		
	packages keysDo: [ :aSymbol | 
		(anExtensionName beginsWithEmpty: (aSymbol asString, ''-'') caseSensitive: false)
			ifTrue: [ ^ true]].
	^ false
	'.
	
MCPackageLoader compile: 'tryToLoad: aDefinition
	aDefinition isClassDefinition ifTrue: [ ^ false ].
		
	[aDefinition addMethodAdditionTo: methodAdditions] on: Error do: [errorDefinitions add: aDefinition].'.

EpMonitor disableDuring: [
	Metacello new	
		githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';	
		baseline: 'Iceberg';	
		load.
    "Metacello new 
		baseline: 'GToolkitReleaser'; 
		githubUser: 'feenkcom' project: 'gtoolkit-releaser' commitish: 'master' path: ''; 
		load.
    GtRlRepositoriesCloner loadProject: 'GToolkit' fromRepository: 'github://feenkcom/gtoolkit/src'."
	Metacello new 
		baseline: 'GToolkit'; 
		repository: 'github://feenkcom/gtoolkit/src';
		silently;
		onConflictUseIncoming;
		load.
].


PharoLightTheme beCurrent.
#GtImageSetup asClass performLocalSetup.
World closeAllWindowsDiscardingChanges.
Smalltalk snapshot: true andQuit: false.
