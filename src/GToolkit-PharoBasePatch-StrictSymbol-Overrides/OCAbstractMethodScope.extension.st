Extension { #name : #OCAbstractMethodScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCAbstractMethodScope >> lookupVar: name [
	"Variable names are Symbols; callers such as Context>>#tempNamed: pass Strings"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := name isString ifTrue: [ name asSymbol ] ifFalse: [ name ].
	copiedVars at: aName ifPresent: [:v | ^ v].
	tempVector at: aName ifPresent: [:v | ^ v].
	tempVars at: aName ifPresent: [:v | ^ v].
	aName == self tempVectorName ifTrue: [ ^ self tempVectorVar ].
	^ super lookupVar: aName
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCAbstractMethodScope >> tempVectorName [
	"the name of the tempVector is not a valid name of a temp variable
	 This way we avoid name clashes "
	"A Symbol, like the names of the other variables (OCVariableNode>>#name: uses asSymbol)"
	<gtPharoPatch: #StrictComparison>
	^ ('0vector', id asString) asSymbol
]
