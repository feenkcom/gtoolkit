Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SequenceableCollection >> stringContentIncludes: anObject [
	"Answer whether anObject is one of the receiver's elements.
	Strings and Symbols with the same content are considered equal."

	^ (self stringContentIndexOf: anObject) ~= 0
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SequenceableCollection >> stringContentIndexOf: anElement [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer 0.
	Compare Strings and Symbols based on their content."
	"(#(a b c d e) indexOf: #c) >>> 3"
	"(#(a b c d e) indexOf: #x) >>> 0"

	^ self stringContentIndexOf: anElement ifAbsent: 0
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SequenceableCollection >> stringContentIndexOf: anElement ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement within the
	receiver. If the receiver does not contain anElement, answer the
	result of evaluating the argument, exceptionBlock.
	Compare Strings and Symbols based on their content."
	"(#(a b c d e) indexOf: #c ifAbsent: 7) >>> 3"
	"(#(a b c d e) indexOf: #x ifAbsent: 7) >>> 7"

	^ self stringContentIndexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SequenceableCollection >> stringContentIndexOf: anElement startingAt: start [
       "Answer the index of the first occurrence of anElement after start within the receiver. If the receiver does not contain anElement, answer 0.
	Compare Strings and Symbols based on their content."
	"(#(a b c d e) indexOf: #c startingAt: 2) >>> 3"
	"(#(a b c d e) indexOf: #c startingAt: 4) >>> 0"

	^self stringContentIndexOf: anElement startingAt: start ifAbsent: 0
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SequenceableCollection >> stringContentIndexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock.
	Compare Strings and Symbols based on their content."

	"(#(a b c d e) indexOf: #c startingAt: 2 ifAbsent: 7) >>> 3"

	"(#(a b c d e) indexOf: #c startingAt: 4 ifAbsent: 7) >>> 7"

	start
		to: self size
		do: [ :index | ((self at: index) sameContentAs: anElement) ifTrue: [ ^ index ] ].
	^ exceptionBlock value
]
