Extension { #name : #FFIInferenceResolutionMode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIInferenceResolutionMode >> resolveUndeclaredTypeForArgument: aFFIValueArgument withResolver: aResolver [

	"Convert 'nil' and 'NULL' to symbols"
	(aFFIValueArgument value isNil
		or: [aFFIValueArgument value = #'nil'
			or: [ aFFIValueArgument value = #'NULL' ]])
				ifTrue: [ ^ (aResolver resolveType: #'void *') ].
	(#(true false) includes: aFFIValueArgument value)
		ifTrue: [ ^ aResolver resolveType: #bool ].
	aFFIValueArgument value isInteger
		ifTrue: [ ^ (aFFIValueArgument value >=0
			ifTrue: [ aResolver resolveType: #uint32 ]
			ifFalse: [ aResolver resolveType: #int32 ]) ].
	(aFFIValueArgument value == #self) ifTrue: [
		^ (aResolver requestor asExternalTypeOn: aResolver)
			prepareAsSelfFromCalloutDeclaration ].

	^ aFFIValueArgument value isSymbol
		ifTrue: [
			"This is actually a class variable with a value..."
			aResolver resolveType: aFFIValueArgument value ]
		ifFalse: [ aResolver unsupportedUntypedLiteral: aFFIValueArgument value ]
]
