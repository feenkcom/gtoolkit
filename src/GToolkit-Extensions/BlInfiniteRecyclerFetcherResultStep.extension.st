Extension { #name : #BlInfiniteRecyclerFetcherResultStep }

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResultStep >> gtDescription [
	^ self recyclerFetcher class name
]

{ #category : #'*GToolkit-Extensions' }
BlInfiniteRecyclerFetcherResultStep >> gtFetcherSteps [
	^ substeps ifNil: [ #() ]
]
