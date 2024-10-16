Extension { #name : #IRMethod }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IRMethod >> initialize [

	irPrimitive := IRPrimitive null.
	tempMap := GtStringContentDictionary new.
	pragmas := OrderedCollection new.
	additionalLiterals := OCLiteralSet new.
	numArgs := 0
]
