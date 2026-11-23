Extension { #name : #ReUnconditionalRecursionRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReUnconditionalRecursionRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	^ (mappingDict at: #'`@.before') noneSatisfy: #containsReturn
]
