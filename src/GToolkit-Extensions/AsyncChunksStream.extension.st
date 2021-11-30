Extension { #name : #AsyncChunksStream }

{ #category : #'*GToolkit-Extensions' }
AsyncChunksStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncChunksStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('capacity=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (capacity printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
