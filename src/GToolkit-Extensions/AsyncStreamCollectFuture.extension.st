Extension { #name : 'AsyncStreamCollectFuture' }

{ #category : '*GToolkit-Extensions' }
AsyncStreamCollectFuture >> gtCompositionChildren [

	^ { stream }
]

{ #category : '*GToolkit-Extensions' }
AsyncStreamCollectFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('species=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (species printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
