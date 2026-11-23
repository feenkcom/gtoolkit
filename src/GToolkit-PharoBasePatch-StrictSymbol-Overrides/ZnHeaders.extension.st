Extension { #name : #ZnHeaders }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnHeaders >> normalizeHeaderKey: string [
	"Header names are Strings; callers pass Symbols"
	<gtPharoPatch: #StrictComparison>
	"Test string to see if it has proper header key capitalization,
	if true, return string, if not, return a properly capitalized copy"

	"Optimization: if string is a know,, properly capitalized header, use it as is"
	string isSymbol ifTrue: [ ^ self normalizeHeaderKey: string asString ].
	(CommonHeaders includes: string)
		ifTrue: [ ^ string ].
	^ (ZnUtils isCapitalizedString: string)
		ifTrue: [ string ]
		ifFalse: [ ZnUtils capitalizeString: string ]
]
