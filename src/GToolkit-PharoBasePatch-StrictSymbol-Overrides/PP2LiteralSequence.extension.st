Extension { #name : #PP2LiteralSequence }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
PP2LiteralSequence >> parseOn: aPP2Context [
	| position |
	position := aPP2Context rememberPosition.
	(node literal sameContentAs: (aPP2Context next: node size))
		ifTrue: [ ^ node literal ].
	aPP2Context restorePosition: position.
	^ PP2Failure message: 'literal not found' context: aPP2Context
]
