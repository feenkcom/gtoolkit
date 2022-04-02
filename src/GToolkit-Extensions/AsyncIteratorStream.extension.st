Extension { #name : #AsyncIteratorStream }

{ #category : #'*GToolkit-Extensions' }
AsyncIteratorStream >> gtCompositionDescription [

	^ self printString asRopedText 
		  append: ': ' asRopedText;
		  append: (iterator printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]
