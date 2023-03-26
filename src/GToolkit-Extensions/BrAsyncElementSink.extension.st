Extension { #name : #BrAsyncElementSink }

{ #category : #'*Gtoolkit-Extensions' }
BrAsyncElementSink >> gtCompositionChildren [
	^ {sink}
]

{ #category : #'*Gtoolkit-Extensions' }
BrAsyncElementSink >> gtCompositionDescription [
	^ self printString asRopedText
		append: ': ' asRopedText;
		append: ('element=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		append: (updater element printString asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor)
]
