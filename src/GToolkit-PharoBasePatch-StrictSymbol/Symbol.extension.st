Extension { #name : #Symbol }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Symbol >> isStrictString [
	"Answer whether the receiver is a String that is not a Symbol"

	^ false
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Symbol >> sameContentAs: aString [
	"Compare the receiver and aString."
	self == aString ifTrue: [^ true].
	self class == aString class ifTrue: [^ false].
	"Use String comparison otherwise"
	^ super sameContentAs: aString
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Symbol class >> strictComparison [
	"Answer whether Strings and Symbols with the same contents are different.
	See GtStrictSymbolComparisonFlag"

	^ GtStrictSymbolComparisonFlag useStrictComparison
]
