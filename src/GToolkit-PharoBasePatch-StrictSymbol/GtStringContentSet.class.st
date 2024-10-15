Class {
	#name : #GtStringContentSet,
	#superclass : #Set,
	#category : #'GToolkit-PharoBasePatch-StrictSymbol-Collections'
}

{ #category : #private }
GtStringContentSet >> scanFor: anObject [
	"Scan the key array for the first slot containing either a nil (indicating an empty slot) or an element that matches anObject. Answer the index of that slot or raise an error if no slot is found. This method will be overridden in various subclasses that have different interpretations for matching elements."

	| index start |
	index := start := anObject hash \\ array size + 1.
	[
		| element |
		((element := array at: index) == nil or: [ element enclosedElement sameContentAs: anObject ])
			ifTrue: [ ^index ].
		(index := index \\ array size + 1) = start ] whileFalse.
	self errorNoFreeSpace
]
