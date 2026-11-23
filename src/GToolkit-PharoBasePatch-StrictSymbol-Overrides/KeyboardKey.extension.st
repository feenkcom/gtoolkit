Extension { #name : #KeyboardKey }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
KeyboardKey class >> named: aString [
	"Returns the instance of myself having aString as name."
	"KeyNameTable is keyed by Symbols (initializeKeyTable: `keyname asString asUppercase asSymbol`); callers pass Strings"
	<gtPharoPatch: #StrictComparison>

	"(KeyboardKey named: 'SHIFT_L') >>> (KeyboardKey value: 65505)"

	^ KeyNameTable at: (aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ])
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
KeyboardKey class >> named: aString ifNone: aBlock [
	"KeyNameTable is keyed by Symbols (see named:); callers pass Strings"
	<gtPharoPatch: #StrictComparison>
	"Returns the instance of myself having aString as name."

	"(KeyboardKey named: 'SHIFT_L') >>> (KeyboardKey value: 65505)"

	^ KeyNameTable at: (aString isString ifTrue: [ aString asSymbol ] ifFalse: [ aString ]) ifAbsent: aBlock
]
