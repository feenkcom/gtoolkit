Extension { #name : #AsyncFlattenFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncFlattenFuture >> gtCompositionChildren [

	^ { future }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFlattenFuture >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('state=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (state printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
