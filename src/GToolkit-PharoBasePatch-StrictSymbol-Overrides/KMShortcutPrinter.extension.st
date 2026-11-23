Extension { #name : #KMShortcutPrinter }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
KMShortcutPrinter class >> symbolTableAt: anObject ifAbsent: aBlock [
	"The symbol table is keyed by Symbols; callers pass Strings"
	<gtPharoPatch: #StrictComparison>

	^ self symbolTable
		at: (anObject isString ifTrue: [ anObject asSymbol ] ifFalse: [ anObject ])
		ifAbsent: aBlock
]
