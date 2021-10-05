Extension { #name : #AsyncMapStream }

{ #category : #'*GToolkit-Extensions' }
AsyncMapStream >> gtCompositionChildren [

	^ { stream } 
]

{ #category : #'*GToolkit-Extensions' }
AsyncMapStream >> gtCompositionDescription [

	^ self printString asRopedText 
		  append: ': ' asRopedText;
		  append: (mapBlock printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
