Extension { #name : #FFIInferenceResolutionMode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIInferenceResolutionMode >> resolveUndeclaredTypeForArgument: aFFIValueArgument withResolver: aResolver [
	"Constant values are Symbols in literal-array signatures and Strings in String signatures"
	<gtPharoPatch: #StrictComparison>
	| aValue |
	aValue := aFFIValueArgument value.
	(aValue isNil
		or: [ aValue isString and: [ aValue asString = 'nil' or: [ aValue asString = 'NULL' ] ] ])
				ifTrue: [ ^ (aResolver resolveType: #'void *') ].
	(#(true false) includes: aValue)
		ifTrue: [ ^ aResolver resolveType: #bool ].
	aValue isInteger
		ifTrue: [ ^ (aValue >=0
			ifTrue: [ aResolver resolveType: #uint32 ]
			ifFalse: [ aResolver resolveType: #int32 ]) ].
	(aValue isString and: [ aValue asString = 'self' ]) ifTrue: [
		^ (aResolver requestor asExternalTypeOn: aResolver)
			prepareAsSelfFromCalloutDeclaration ].

	^ aValue isSymbol
		ifTrue: [
			"This is actually a class variable with a value..."
			aResolver resolveType: aValue ]
		ifFalse: [ aResolver unsupportedUntypedLiteral: aValue ]
]
