Extension { #name : #ReStringConcatenationRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReStringConcatenationRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	(self performsConcatenation: (mappingDict at: #'``@argument'))
		ifTrue: [ ^ true ].

	(mappingDict
		at: #'``@argument2'
		ifPresent: [ :arg2 |
			^ self performsConcatenation: arg2 ]).

	^ false
]
