Extension { #name : #AsyncObservableValue }

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtCompositionChildren [

	^ stream
		  ifNotNil: [ :aStream | 
			  aStream == self
				  ifFalse: [ { aStream } ]
				  ifTrue: [ #(  ) ] ]
		  ifNil: [ #(  ) ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ('value=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (self valueOrNil printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]
