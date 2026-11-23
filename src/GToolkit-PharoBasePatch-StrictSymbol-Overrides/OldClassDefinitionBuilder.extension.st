Extension { #name : #OldClassDefinitionBuilder }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OldClassDefinitionBuilder >> if: selectorParts includes: aSymbol do: aBlock [
	"selectorParts are Strings (findBetweenSubstrings:), aSymbol a Symbol literal"
	<gtPharoPatch: #StrictComparison>
	| index |
	index := selectorParts indexOf: aSymbol asString ifAbsent: [ ^ self ].
	aBlock value: (ast arguments at: index)
]
