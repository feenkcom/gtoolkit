Extension { #name : 'AsyncMapFuture' }

{ #category : '*GToolkit-Extensions' }
AsyncMapFuture >> gtCompositionChildren [

	^ { future }
]

{ #category : '*GToolkit-Extensions' }
AsyncMapFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: (mapBlock printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
