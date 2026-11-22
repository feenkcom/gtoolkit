Extension { #name : #TextStyle }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TextStyle class >> named: familyName [
	"Answer the TextStyle with the given name, or nil."
	"TextStyle named: 'NewYork'"
	"TextSharedInformation is keyed by Symbols; LogicalFontManager>>#bestFontFor:whenFindingAlternativeIgnoreAll: passes the family names as Strings (TextStyle>>#addNewFontSize: also looks up with asSymbol)"
	<gtPharoPatch: #StrictComparison>
	| textStyle |
	textStyle := TextSharedInformation
		at: (familyName isString ifTrue: [ familyName asSymbol ] ifFalse: [ familyName ])
		ifAbsent: [ ^ nil ].
	(textStyle isKindOf: self) ifFalse: [ ^ nil ].
	^ textStyle
]
