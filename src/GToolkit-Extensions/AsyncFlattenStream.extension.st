Extension { #name : #AsyncFlattenStream }

{ #category : #'*GToolkit-Extensions' }
AsyncFlattenStream >> gtCompositionChildren [
	^ { stream. next }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFlattenStream >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('stream=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (stream printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (', next=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (next printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
