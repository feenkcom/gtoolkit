Extension { #name : 'GtSearchBinaryFilter' }

{ #category : '*GToolkit-Extensions' }
GtSearchBinaryFilter >> children [
	^ { self leftFilter. self rightFilter }
]
