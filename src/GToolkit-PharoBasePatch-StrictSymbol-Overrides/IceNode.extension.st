Extension { #name : #IceNode }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceNode >> initialize [

	super initialize.
	childrenDictionary := GtStringContentDictionary new
]
