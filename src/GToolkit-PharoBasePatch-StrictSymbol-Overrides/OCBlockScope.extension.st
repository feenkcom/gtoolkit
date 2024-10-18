Extension { #name : #OCBlockScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCBlockScope >> inComingCopiedVarNames [
	^ self copiedVarNames stringContentIntersection: outerScope copiedVarNames
]
