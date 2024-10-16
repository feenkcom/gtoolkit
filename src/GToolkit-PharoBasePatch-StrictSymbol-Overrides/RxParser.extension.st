Extension { #name : #RxParser }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RxParser >> inputUpTo: aCharacter nestedOn: anotherCharacter errorMessage: aString [
	"Accumulate input stream until <aCharacter> is encountered
	and answer the accumulated chars as String, not including
	<aCharacter>. Signal error if end of stream is encountered,
	passing <aString> as the error description."

	| accumulator nestLevel |
	accumulator := WriteStream on: (String new: 20).
	nestLevel := 0.
	[ lookahead ~= aCharacter or: [ nestLevel > 0 ] ]
		whileTrue: [ ('epsilon' sameContentAs: lookahead)
				ifTrue: [ self signalParseError: aString ].
			accumulator nextPut: lookahead.
			lookahead = anotherCharacter ifTrue: [ nestLevel := nestLevel + 1 ].
			lookahead = aCharacter ifTrue: [ nestLevel := nestLevel - 1 ].
			self next ].
	^ accumulator contents
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RxParser >> piece [
	"<piece> ::= <atom> | <atom>* | <atom>+ | <atom>? | <atom>{<number>,<number>}"

	| atom |
	atom := self atom.

	(lookahead sameContentAs: $*)
		ifTrue: [ self next.
			atom isNullable ifTrue: [ self signalNullableClosureParserError ].
			^ RxsPiece new initializeStarAtom: atom ].

	(lookahead sameContentAs: $+)
		ifTrue: [ self next.
			atom isNullable ifTrue: [ self signalNullableClosureParserError ].
			^ RxsPiece new initializePlusAtom: atom ].

	(lookahead sameContentAs: $?)
		ifTrue: [ self next.
			atom isNullable ifTrue: [ ^ self lookAround ].
			^ RxsPiece new initializeOptionalAtom: atom ].

	(lookahead sameContentAs: ${) ifTrue: [ ^ self quantifiedAtom: atom ].

	^ RxsPiece new initializeAtom: atom
]
