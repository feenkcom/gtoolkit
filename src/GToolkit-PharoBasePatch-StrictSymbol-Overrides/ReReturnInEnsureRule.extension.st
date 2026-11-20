Extension { #name : #ReReturnInEnsureRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReReturnInEnsureRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	^ (mappingDict at: #'`@.Stmts')
		anySatisfy: #containsReturn
]
