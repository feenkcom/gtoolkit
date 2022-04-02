Extension { #name : #AsyncDelayedFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncDelayedFuture >> gtCompositionChildren [
	^ { future }
]

{ #category : #'*GToolkit-Extensions' }
AsyncDelayedFuture >> gtCompositionDescription [
	^ self printString asRopedText
		appendString: ': ';
		append: ('delay=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		append: (delay printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		append: (' since ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		append: (self waitDuration humanReadablePrintString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
