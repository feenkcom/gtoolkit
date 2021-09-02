Extension { #name : 'AsyncFlattenStream' }

{ #category : '*GToolkit-Extensions' }
AsyncFlattenStream >> gtCompositionChildren [
	^ { stream }
]

{ #category : '*GToolkit-Extensions' }
AsyncFlattenStream >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('next=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (next printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
