Extension { #name : #ReFloatEqualityComparisonRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReFloatEqualityComparisonRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	^ (mappingDict at: #'`#floatLiteral') value isFloat
]
