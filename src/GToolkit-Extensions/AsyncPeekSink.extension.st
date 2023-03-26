Extension { #name : #AsyncPeekSink }

{ #category : #'*Gtoolkit-Extensions' }
AsyncPeekSink >> gtCompositionDescription [
	^ self printString asRopedText
		append: ': ' asRopedText;
		append: ('value=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		append: (self value printString asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor)
]
