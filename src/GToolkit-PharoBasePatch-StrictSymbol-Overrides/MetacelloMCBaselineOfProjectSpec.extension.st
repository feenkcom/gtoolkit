Extension { #name : #MetacelloMCBaselineOfProjectSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMCBaselineOfProjectSpec >> hasClassName [
	"className: is given a String or a Symbol; #constructClassName answers a String"
	<gtPharoPatch: #StrictComparison>

	^ className isNotNil and: [ className asString ~= self constructClassName ]
]
