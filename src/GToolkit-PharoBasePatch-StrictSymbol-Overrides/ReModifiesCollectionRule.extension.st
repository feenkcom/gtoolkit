Extension { #name : #ReModifiesCollectionRule }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReModifiesCollectionRule >> afterCheck: aNode mappings: mappingDict [
	"RePatternCodeRule>>#flattenMatchMap: keys the mappings by the pattern variable names (Symbols)"
	<gtPharoPatch: #StrictComparison>
	^ self
		modifiesCollection: (mappingDict at: #'`@collection')
		inAnyStatement: (mappingDict at: #'`@.Statements')
]
