Extension { #name : #OCKeywordToken }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCKeywordToken >> isPrimitiveKeyword [
	"Token values are Strings (buffer contents)"
	<gtPharoPatch: #StrictComparison>
	^ self value asString = 'primitive:'
]
