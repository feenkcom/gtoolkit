Extension { #name : #SourceFileArray }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SourceFileArray >> timeStampAt: sourcePointer for: sourceDataPointers [
	"Answer the authoring time-stamp for the given method, retrieved from the sources or changes file. Answer the empty string if no time stamp is available."

	| preamble stamp tokens stampPosition |
	stamp := ''.
	flushChanges ifFalse: [ ^ stamp ].
	preamble := self sourcedDataAt: sourcePointer.
	(preamble includesSubstring: sourceDataPointers key)
		ifTrue: [
			tokens := preamble parseLiterals.
			stampPosition := tokens stringContentIndexOf: sourceDataPointers value.
			stampPosition = 0
				ifFalse: [
					"New format gives change stamp and unified prior pointer"
					stamp := tokens at: stampPosition + 1 ] ].
	^ stamp
]
