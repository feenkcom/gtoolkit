Extension { #name : #RBKeywordToken }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBKeywordToken >> isPrimitiveKeyword [

	^ self value = 'primitive:'
]
