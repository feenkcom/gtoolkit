Extension { #name : #OCIRBuilder }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCIRBuilder >> addTemp: tempKey [
	"Temp names are Symbols (variable names); some generators (FFI) pass Strings: key the temp map by Symbols.
	Other keys (the decompiler uses Associations and OCIRRemoteArray objects) are kept as they are."
	<gtPharoPatch: #StrictComparison>
	| tempMap aKey |
	aKey := tempKey isString ifTrue: [ tempKey asSymbol ] ifFalse: [ tempKey ].
	tempMap := self currentScope tempMap.

	"adding the same var multiple times reuses the same offset"
	(tempMap includesKey: aKey) ifTrue: [ ^ 	self cacheIndex: aKey ].

	tempMap at: aKey put: tempMap size + 1.
	self cacheIndex: aKey
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCIRBuilder >> cacheIndex: tempKey [
	"if we have the ast, we can store the temp offset"
	<gtPharoPatch: #StrictComparison>
	| aKey |
	aKey := tempKey isString ifTrue: [ tempKey asSymbol ] ifFalse: [ tempKey ].
	self sourceNode ifNotNil: [ :sourceNode |
		| var |
		var := sourceNode scope lookupVar: aKey.
		"some vars (e.g. limits in loops) do not exist on the AST level"
		var ifNotNil: [ var index: (self currentScope tempMap at: aKey) ] ]
]
