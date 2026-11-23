Extension { #name : #MetacelloMCConfigurationOfProjectSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMCConfigurationOfProjectSpec >> hasClassName [
	"className: is given a String or a Symbol; #constructClassName answers a String"
	<gtPharoPatch: #StrictComparison>

	^ className isNotNil and: [ className asString ~= self constructClassName ]
]
