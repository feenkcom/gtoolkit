Extension { #name : #AsyncPollFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: (pollBlock printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
