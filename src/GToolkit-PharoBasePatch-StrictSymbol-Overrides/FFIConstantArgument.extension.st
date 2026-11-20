Extension { #name : #FFIConstantArgument }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIConstantArgument >> resolveUsing: aResolver [
	"NULL comes as a Symbol (literal-array signatures) or a String (String signatures); only the Symbol #self means self
	(a 'self' String constant is a literal, see FFIFunctionResolutionTest>>#testResolveConstantSelfStringShouldSetConstantLoader)"
	<gtPharoPatch: #StrictComparison>

	value = false ifTrue: [
		loader := FFILiteralArgument value: 0 type: (aResolver resolveType: #bool).
		resolvedType := type resolveUsing: aResolver forArgument: self.
		resolvedType loader: loader.
		^ self ].
	value = true ifTrue: [
		loader := FFILiteralArgument value: 1 type: (aResolver resolveType: #bool).
		resolvedType := type resolveUsing: aResolver forArgument: self.
		resolvedType loader: loader.
		^ self ].
	(value isNil or: [ value isString and: [ value asString = 'NULL' ] ]) ifTrue: [
		loader := FFILiteralArgument value: ExternalAddress null type: (aResolver resolveType: #'void *').
		resolvedType := type resolveUsing: aResolver forArgument: self.
		resolvedType loader: loader.
		^ self ].
	value == #self ifTrue: [
		loader := resolvedType := type resolveUsing: aResolver forArgument: self.
		loader loader: FFISelfArgument new.
		^ self ].
	loader := FFILiteralArgument value: value.
	resolvedType := type resolveUsing: aResolver forArgument: self.
	resolvedType loader: loader
]
