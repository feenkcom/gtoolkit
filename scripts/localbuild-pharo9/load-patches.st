| patcher |

EpMonitor current disable.
Iceberg enableMetacelloIntegration: false.

Metacello new
    githubUser: 'syrel' project: 'pharo9-backport' commitish: 'main' path: '';
    baseline: 'PharoPatcher';
    load.

patcher := #PharoPatcher asClass.

NonInteractiveTranscript stdout
    nextPutAll: 'Patching Pharo9 image...';
    cr.

"===================================
    Patch Pharo8 random crashes
==================================="

patcher patch: Context source:
'copyTo: aContext
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

patcher patch: SourceFileArray source: 'deferFlushDuring: aBlock
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

patcher patch: RPackageOrganizer source: 'packageMatchingExtensionName: anExtensionName
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

patcher patch: RPackageOrganizer source: 'hasPackageMatchingExtensionName: anExtensionName
	(self hasPackageExactlyMatchingExtensionName: anExtensionName)
		ifTrue: [ ^true ].

	packages keysDo: [ :aSymbol |
		(anExtensionName beginsWithEmpty: (aSymbol asString, ''-'') caseSensitive: false)
			ifTrue: [ ^ true]].
	^ false'.

patcher patch: MCPackageLoader source: 'tryToLoad: aDefinition
	aDefinition isClassDefinition ifTrue: [ ^ false ].

	[aDefinition addMethodAdditionTo: methodAdditions] on: Error do: [errorDefinitions add: aDefinition].'.

"===================================
        Patch Library names
==================================="
PharoPatcher patch: #LGitLibrary asClass source:
'macLibraryName

 	^ FFIMacLibraryFinder findAnyLibrary: #(''libgit2.dylib'' ''libgit2.1.0.1.dylib'' ''libgit2.1.0.0.dylib'' ''libgit2.0.25.1.dylib'')'
classified: 'accessing - platform'.
"===================================
            Clean up
==================================="

EpMonitor current enable.
Iceberg enableMetacelloIntegration: true.

Smalltalk snapshot: true andQuit: false.