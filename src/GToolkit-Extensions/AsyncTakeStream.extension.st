Extension { #name : 'AsyncTakeStream' }

{ #category : '*GToolkit-Extensions' }
AsyncTakeStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : '*GToolkit-Extensions' }
AsyncTakeStream >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('remaining = ' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (remaining printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
