Extension { #name : #ReTrueFalseDuplicationRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReTrueFalseDuplicationRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>

	mappingDict
		at: #'`.LastStatement'
		ifPresent: [ :statement |
			^ statement isVariable not ].

	"the first statement is duplicated"
	^ true
]
