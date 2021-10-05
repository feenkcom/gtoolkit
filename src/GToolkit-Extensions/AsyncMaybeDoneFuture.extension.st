Extension { #name : #AsyncMaybeDoneFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncMaybeDoneFuture >> gtCompositionChildren [

	^ state ifNotNil: [ :anAssoc | 
		  anAssoc key = #future
			  ifTrue: [ { state value } ]
			  ifFalse: [ #(  ) ] ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncMaybeDoneFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: (state printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
