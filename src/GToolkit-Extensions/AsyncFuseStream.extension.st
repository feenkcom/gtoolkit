Extension { #name : #AsyncFuseStream }

{ #category : #'*GToolkit-Extensions' }
AsyncFuseStream >> gtCompositionChildren [

	^ { stream }
]

{ #category : #'*GToolkit-Extensions' }
AsyncFuseStream >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('done=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (done printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
