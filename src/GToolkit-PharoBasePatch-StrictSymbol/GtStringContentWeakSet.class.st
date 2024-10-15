Class {
	#name : #GtStringContentWeakSet,
	#superclass : #WeakSet,
	#category : #'GToolkit-PharoBasePatch-StrictSymbol-Collections'
}

{ #category : #private }
GtStringContentWeakSet >> scanFor: anObject [
	"Scan the key array for the first slot containing either flag (indicating an empty slot) or an element that matches anObject. Answer the index of that slot or raise an error if no slot is found. This method will be overridden in various subclasses that have different interpretations for matching elements."
	<gtSymbolStrictComparison>
	| index start |
	index := start := anObject hash \\ array size + 1.
	[
		| element |
		((element := array at: index) == flag or: [ element enclosedElement sameContentAs: anObject ])
			ifTrue: [ ^index ].
		(index := index \\ array size + 1) = start ] whileFalse.
	self errorNoFreeSpace
]
