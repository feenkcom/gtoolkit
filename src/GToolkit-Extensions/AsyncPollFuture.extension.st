Extension { #name : #AsyncPollFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ((pollBlock ifNil: [ executedBlock ]) printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
