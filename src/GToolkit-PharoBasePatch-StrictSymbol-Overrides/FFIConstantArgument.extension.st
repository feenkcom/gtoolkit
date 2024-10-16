Extension { #name : #FFIConstantArgument }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFIConstantArgument >> resolveUsing: aResolver [

	(value sameContentAs: false)
		ifTrue: [ loader := FFILiteralArgument value: 0 type: (aResolver resolveType: #bool).
			resolvedType := type resolveUsing: aResolver forArgument: self.
			resolvedType loader: loader.
			^ self ].
	(value sameContentAs: true)
		ifTrue: [ loader := FFILiteralArgument value: 1 type: (aResolver resolveType: #bool).
			resolvedType := type resolveUsing: aResolver forArgument: self.
			resolvedType loader: loader.
			^ self ].
	(value isNil or: [ value = #NULL ])
		ifTrue: [ loader := FFILiteralArgument
					value: ExternalAddress null
					type: (aResolver resolveType: #'void *').
			resolvedType := type resolveUsing: aResolver forArgument: self.
			resolvedType loader: loader.
			^ self ].
	value == #self
		ifTrue: [ loader := resolvedType := type resolveUsing: aResolver forArgument: self.
			loader loader: FFISelfArgument new.
			^ self ].
	loader := FFILiteralArgument value: value.
	resolvedType := type resolveUsing: aResolver forArgument: self.
	resolvedType loader: loader
]
