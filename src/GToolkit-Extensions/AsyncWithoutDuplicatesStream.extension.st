Extension { #name : #AsyncWithoutDuplicatesStream }

{ #category : #'*GToolkit-Extensions' }
AsyncWithoutDuplicatesStream >> gtCompositionChildren [

	^ { stream } 
]

{ #category : #'*GToolkit-Extensions' }
AsyncWithoutDuplicatesStream >> gtCompositionDescription [

	| aString |
	aString := self printString asRopedText append: ': ' asRopedText.
	comparisonBlock ifNotNil: [ 
		aString append:
			(comparisonBlock printString asRopedText foreground:
				 BrGlamorousColors disabledButtonTextColor) ].
	^ aString
]
