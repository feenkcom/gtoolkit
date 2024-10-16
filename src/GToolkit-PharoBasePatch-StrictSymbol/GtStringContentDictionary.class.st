Class {
	#name : #GtStringContentDictionary,
	#superclass : #Dictionary,
	#category : #'GToolkit-PharoBasePatch-StrictSymbol-Collections'
}

{ #category : #converting }
GtStringContentDictionary >> asGtStringContentDictionary [

	^ self
]

{ #category : #private }
GtStringContentDictionary >> scanFor: anObject [
	"Scan the key array for the first slot containing either a nil (indicating an empty slot) or an element that matches anObject. Answer the index of that slot or zero if no slot is found. This method will be overridden in various subclasses that have different interpretations for matching elements."
	| element start finish |
	<gtSymbolStrictComparison>
	finish := array size.
	start := (anObject hash \\ finish) + 1.

	"Search from (hash mod size) to the end."
	start to: finish do:
		[:index | ((element := array at: index) == nil or: [element key sameContentAs: anObject])
			ifTrue: [^ index ]].

	"Search from 1 to where we started."
	1 to: start-1 do:
		[:index | ((element := array at: index) == nil or: [element key sameContentAs: anObject])
			ifTrue: [^ index ]].

	^ 0  "No match AND no empty slot"
]

{ #category : #serialization }
GtStringContentDictionary >> stonOn: stonWriter [
	"Instances of STON mapClass will be encoded directly, without a class tag.
	Other (sub)classes will be encoded with a class tag and will use a map representation. "

	stonWriter writeMap: self
]
