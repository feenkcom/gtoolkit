Extension { #name : #AsyncFilterStream }

{ #category : #'*GToolkit-Extensions' }
AsyncFilterStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFilterStream >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('filter=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (filter printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
