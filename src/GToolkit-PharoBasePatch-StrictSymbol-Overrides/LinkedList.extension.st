Extension { #name : #LinkedList }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
LinkedList >> stringContentIndexOf: anElement startingAt: start ifAbsent: exceptionBlock [
	"Answer the index of the first occurrence of anElement after start
	within the receiver. If the receiver does not contain anElement,
	answer the 	result of evaluating the argument, exceptionBlock.
	Compare Strings and Symbols based on their content."
	| currentLink index |

	currentLink := self linkAt: start ifAbsent: [ nil ].
	index := start.
	[ currentLink isNil ]
		whileFalse: [ (currentLink value sameContentAs: anElement value) ifTrue: [ ^ index ].
			currentLink := currentLink nextLink.
			index := index + 1 ].
	^ exceptionBlock value
]
