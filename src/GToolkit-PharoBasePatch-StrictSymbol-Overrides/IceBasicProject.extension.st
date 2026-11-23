Extension { #name : #IceBasicProject }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceBasicProject >> sourceDirectory [
	"The properties read from .project files have String or Symbol keys (both kinds occur in the registered repositories): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	
	^ properties at: 'srcDirectory' ifAbsent: [ properties at: #srcDirectory ifAbsent: [ 'src' ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceBasicProject >> sourceDirectory: aString [
	"The properties read from .project files have String or Symbol keys: replace the value of the existing key, of either kind, rather than adding a second key"
	<gtPharoPatch: #StrictComparison>
	
	properties
		at: ((properties includesKey: #srcDirectory) ifTrue: [ #srcDirectory ] ifFalse: [ 'srcDirectory' ])
		put: aString
]
