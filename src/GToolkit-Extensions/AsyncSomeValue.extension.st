Extension { #name : 'AsyncSomeValue' }

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtCompositionChildren [

	^ (self value class isComposedBy: TAsyncFuture)
		  ifTrue: [ { self value } ]
		  ifFalse: [ #(  ) ]
]

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('value=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (self value printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
