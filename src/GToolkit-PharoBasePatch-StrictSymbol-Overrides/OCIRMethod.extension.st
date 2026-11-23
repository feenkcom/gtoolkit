Extension { #name : #OCIRMethod }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCIRMethod >> indexForVarNamed: aName [
	"The temp map is keyed by Symbols (OCIRBuilder>>#addTemp:)"
	<gtPharoPatch: #StrictComparison>

	^tempMap at: (aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ])
]
