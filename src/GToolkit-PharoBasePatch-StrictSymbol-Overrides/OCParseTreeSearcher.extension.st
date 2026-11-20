Extension { #name : #OCParseTreeSearcher }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCParseTreeSearcher >> variableNamed: aString [
	"The context is keyed by pattern variable nodes, whose names are Symbols"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ].
	^ (context associations detect: [ :assoc | assoc key name = aName  ]) value
]
