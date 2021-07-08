| patcher |

EpMonitor current disable.
Iceberg enableMetacelloIntegration: false.

Metacello new
    githubUser: 'syrel' project: 'pharo9-backport' commitish: 'main' path: '';
    baseline: 'PharoPatcher';
    load.

patcher := #PharoPatcher asClass.

NonInteractiveTranscript stdout
    nextPutAll: 'Patching Pharo8 image...';
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
           Pharo 9 shims
==================================="

patcher patch: BlockClosure source: 'onErrorDo: errorHandlerBlock
	"Evaluate the block represented by the receiver, and normally return it''s value.  If an error occurs, the errorHandlerBlock is evaluated, and it''s value is instead returned.  The errorHandlerBlock must accept zero or one parameter (the error object)."
	"Examples:
		[1 whatsUpDoc] onErrorDo: [:err | ''huh?''].
		[1 / 0] onErrorDo: [:err |
			ZeroDivide = err class
				ifTrue: [Float infinity]
				ifFalse: [self error: err]]
"
	^ self on: Error do: [:ex | errorHandlerBlock cull: ex]'.

patcher patch: Pragma class source: 'allNamed: aSymbol
^ Array streamContents: [ :aStream |
		SystemNavigation default allMethods
			do: [ :eachMethod |
				(eachMethod pragmaAt: aSymbol)
					ifNotNil: [ :aPragma | aStream nextPut: aPragma ] ] ]'.

patcher patch: Class source: 'classVariableNamed: aString ifAbsent: absentBlock
	"Answer the Class Variable"

	^self classPool associationAt: aString asSymbol ifAbsent: absentBlock'.

patcher patch: Context source: 'compiledCode
	^ method'.

patcher patch: OSSDL2ExternalForm source:
'oldPrimCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB
    <primitive: ''primitiveCreateManualSurface'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

patcher patch: OSSDL2ExternalForm source: 'oldPrimDestroyManualSurface: surfaceID
    <primitive: ''primitiveDestroyManualSurface'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

patcher patch: OSSDL2ExternalForm source: 'oldPrimManualSurface: surfaceID setPointer: aPointer
    <primitive: ''primitiveSetManualSurfacePointer'' module: ''SqueakFFIPrims''>
    self primitiveFailed'
classified: 'old - ffi backend support'.

patcher patch: OSSDL2ExternalForm source: 'primCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB
    <primitive: ''primitiveCreateManualSurface'' module: ''SurfacePlugin''>
    ^ self oldPrimCreateManualSurfaceWidth: aWidth height: aHeight rowPitch: rowPitch depth: aDepth isMSB: isMSB'
classified: 'primitives'.

patcher patch: OSSDL2ExternalForm source: 'primDestroyManualSurface: surfaceID
    <primitive: ''primitiveDestroyManualSurface'' module: ''SurfacePlugin''>
    ^ self oldPrimDestroyManualSurface: surfaceID'
classified: 'primitives'.

patcher patch: OSSDL2ExternalForm source: 'primManualSurface: surfaceID setPointer: aPointer
    <primitive: ''primitiveSetManualSurfacePointer'' module: ''SurfacePlugin''>
    ^ self oldPrimManualSurface: surfaceID setPointer: aPointer'
classified: 'primitives'.

"===================================
            Clean up
==================================="

EpMonitor current enable.
Iceberg enableMetacelloIntegration: true.

Smalltalk snapshot: true andQuit: false.